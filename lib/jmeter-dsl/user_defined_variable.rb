module JmeterDsl
  module Jmeter

    class UserDefinedVariable
      attr_accessor :doc
      def initialize(params={})
        @doc = Nokogiri::XML(<<-EOF.strip_heredoc)
          <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments">
              <elementProp name="testguid" elementType="Argument">
                <stringProp name="Argument.name"></stringProp>
                <stringProp name="Argument.value"></stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
            </collectionProp>
            <stringProp name="TestPlan.comments"></stringProp>
          </Arguments>
        EOF
        params.each do |name, value|
          node = @doc.children.xpath("//*[contains(@name,\"#{name.to_s}\")]")
          node.first.content = value unless node.empty? 
        end
      end
    end 

  end
end