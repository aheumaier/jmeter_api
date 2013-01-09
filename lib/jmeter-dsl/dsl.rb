module JmeterDsl

  def dsl_eval(dsl, &block)
    block_context = eval("self", block.binding)
    proxy_context = JmeterDsl::Jmeter::FallbackContextProxy.new(dsl, block_context)
    begin
      block_context.instance_variables.each { |ivar| proxy_context.instance_variable_set(ivar, block_context.instance_variable_get(ivar)) }
      proxy_context.instance_eval(&block)
    ensure
      block_context.instance_variables.each { |ivar| block_context.instance_variable_set(ivar, proxy_context.instance_variable_get(ivar)) }
    end
    dsl
  end

  module_function :dsl_eval

  module Jmeter

    class DSL
      attr_accessor :root

      def initialize
        @root = Nokogiri::XML(<<-EOF.strip_heredoc)
          <?xml version="1.0" encoding="UTF-8"?>
          <jmeterTestPlan version="1.2" properties="2.1">
          <hashTree>
          </hashTree>
          </jmeterTestPlan>
        EOF
        node = JmeterDsl::Jmeter::TestPlan.new
        @root.at_xpath("//jmeterTestPlan/hashTree") << node.doc.children << hash_tree

        variables(
            name: 'testguid',
            value: '${__P(testguid,${__time(,)})}',
            comments: 'The testguid variable is mandatory when running on the Grid.') {}
      end

      def variables(params={}, &block)
        node = JmeterDsl::Jmeter::UserDefinedVariable.new(params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def defaults(params={}, &block)
        node = JmeterDsl::Jmeter::RequestDefaults.new(params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def cookies(params={}, &block)
        node = JmeterDsl::Jmeter::CookieManager.new(params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def cache(params={}, &block)
        node = JmeterDsl::Jmeter::CacheManager.new(params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def auth(params={}, &block)
        node = JmeterDsl::Jmeter::AuthManager.new(params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def threads(num_threads=1, params={}, &block)
        node = JmeterDsl::Jmeter::ThreadGroup.new(num_threads, params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def transaction(name="Transaction Contoller", params={}, &block)
        node = JmeterDsl::Jmeter::Transaction.new(name, params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def exists(var, params={}, &block)
        params[:condition] = "'${#{var}}'.length > 0"
        node = JmeterDsl::Jmeter::IfController.new("if #{var}", params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def once(name="do once", params={}, &block)
        node = JmeterDsl::Jmeter::OnceOnly.new(name, params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def visit(name="HTTP Request", url="", params={}, &block)
        params[:method] = 'GET'
        node = JmeterDsl::Jmeter::HttpSampler.new(name, url, params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      def submit(name="HTTP Request", url="", params={}, &block)
        params[:method] = 'POST'
        node = JmeterDsl::Jmeter::HttpSampler.new(name, url, params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      alias_method :post, :submit

      def extract(*args, &block)
        node = case args.first
                 when :regex
                   JmeterDsl::Jmeter::RegexExtractor.new(*args.last(2))
                 when :xpath
                   JmeterDsl::Jmeter::XpathExtractor.new(*args.last(2))
                 else
                   JmeterDsl::Jmeter::RegexExtractor.new(*args)
               end
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      alias_method :web_reg_save_param, :extract

      def random_timer(delay=0, range=0, &block)
        node = JmeterDsl::Jmeter::GaussianRandomTimer.new(delay, range)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      alias_method :think_time, :random_timer

      def assert(match="contains", pattern="", params={}, &block)
        node = JmeterDsl::Jmeter::ResponseAssertion.new(match, pattern, params)
        last_node_from(caller) << node.doc.children << hash_tree
        self.instance_exec(&block) if block
      end

      alias_method :web_reg_find, :assert

      def out(params={})
        puts doc.to_xml(:indent => 2)
      end

      logger.info "JMX saved to: #{params[:file]}"
    end

    def run(params={})
      file(params)
      raise 'ERROR: Jmeter path not found' unless File.exists?("#{params[:path]}jmeter")
      logger.warn "Test executing locally ..."
      cmd = "#{params[:path]}jmeter -n -t #{params[:file]} -j #{params[:log] ? params[:log] : 'jmeter.log' } -l #{params[:jtl] ? params[:jtl] : 'jmeter.jtl' }"
      logger.info cmd
      `#{cmd}`
      logger.info "Results at: #{params[:jtl] ? params[:jtl] : 'jmeter.jtl'}"
    end

    def grid(token, params={})
      RestClient.proxy = params[:proxy] if params[:proxy]
      begin
        file = Tempfile.new('jmeter')
        file.write(doc.to_xml(:indent => 2))
        file.rewind
        response = RestClient.post "http://#{params[:endpoint] ? params[:endpoint] : 'StackTest.com'}/api?token=#{token}",
                                   {
                                       :name => 'attachment',
                                       :attachment => File.new("#{file.path}", 'rb'),
                                       :multipart => true,
                                       :content_type => 'application/octet-stream'
                                   }
        logger.info "Results at: #{JSON.parse(response)["results"]}" if response.code == 200
      rescue => e
        logger.fatal "There was an error: #{e.message}"
      end
    end

    private

    def hash_tree
      Nokogiri::XML::Node.new("hashTree", @root)
    end

    def last_node_from(calling_method)
      xpath = xpath_from(calling_method)
      node  = @root.xpath(xpath).last
      node
    end

    def xpath_from(calling_method)
      case calling_method.grep(/dsl/)[1][/`.*'/][1..-2]
        when 'threads'
          '//ThreadGroup/following-sibling::hashTree'
        when 'transaction'
          '//TransactionController/following-sibling::hashTree'
        when 'once'
          '//OnceOnlyController/following-sibling::hashTree'
        when 'exists'
          '//IfController/following-sibling::hashTree'
        when 'visit'
          '//HTTPSamplerProxy/following-sibling::hashTree'
        when 'submit'
          '//HTTPSamplerProxy/following-sibling::hashTree'
        when 'extract'
          '//RegexExtractor/following-sibling::hashTree'
        when 'random_timer'
          '//GaussianRandomTimer/following-sibling::hashTree'
        else
          '//TestPlan/following-sibling::hashTree'
      end
    end

    def file(params={})
      params[:file] ||= 'jmeter.jmx'
      File.open(params[:file], 'w') { |file| file.write(doc.to_xml(:indent => 2)) }
    end

    def doc
      Nokogiri::XML(@root.to_s,&:noblanks)
    end

    def logger
      @log ||= Logger.new(STDOUT)
      @log.level = Logger::DEBUG
      @log
    end

  end

end

def test(&block)
  t = JmeterDsl.dsl_eval(JmeterDsl::Jmeter::DSL.new, &block)
  t.out
  t
end

alias_method :webtest, :jmetertest
