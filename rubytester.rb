#!/usr/bin/ruby 
require 'net/http'
#require 'uri'
require 'json'

def find_or_create_project(id=nil)
  begin
    puts 'calling find_or_create_project(' + id + ')'

    if read_project(id).match(/^Entry/)
     create_project(id)
     puts 'Entry not found but created'
    else
      puts 'Entry found'
    end
  rescue Exception=>e 
    raise e
  end
end

# Create an project using a predefined json template as a REST request.
def create_project(name="Default Name", environment="test_env")
  puts 'calling create_project with ' + name
  uri = URI.parse("http://localhost:3000/projects/" )
  post_params = { :name => "#{name}", :environment => "#{environment}" }
  req = Net::HTTP::Post.new(uri.path)
  req.body = JSON.generate(post_params)
  req["Content-Type"] = "application/json"
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.start {|htt| htt.request(req)}
end

# Create an jmeter_run using a predefined json template as a REST request.
def create_run(description="test_description")
  puts 'calling create_run'
  uri = URI.parse("http://localhost:3000/projects/" + @project + "/jmeter_runs")
  post_params = { :description => "#{description}" }
  req = Net::HTTP::Post.new(uri.path)
  req.body = JSON.generate(post_params)
  req["Content-Type"] = "application/json"
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.start {|htt| htt.request(req)}
  @jmeter_id = response.body
end


# Read can get all projects with no arguments or
# get one project with one argument.  For example:
# api = Api.new
# api.read 2 => one employee
# api.read   => all employees
def read_project(id=nil)
  puts 'calling read(' + id + ')'
  request = Net::HTTP.new(@uri_p.host, @uri_p.port)
  if id.nil?
    response = request.get("#{@uri_p.path}.json")
  else
    puts "#{@uri_p.path}/#{id}.json"
    response = request.get("#{@uri_p.path}/#{id}.json")
  end
  return response.body
end

def new_run
  puts 'calling new run'
  find_or_create_project(@project)
    begin 
      create_run('webistrano_run_' + Time.now.to_i.to_s )

    rescue Exception=>e 
      raise e
    end
end

def run_start(j_id = @jmeter_id)
  puts 'start run called'
  begin
    request = Net::HTTP.new(@uri_j.host, @uri_j.port)
    response = request.get("#{@uri_j.path}/#{j_id}/start")
  rescue Exception=>e 
    raise e
  end
end

begin
  @project = "imageGalaDe" #.gsub(".", "_").camelize
  @url_p = "http://localhost:3000/projects"
  @uri_p = URI.parse @url_p
  @url_j = "http://localhost:3000/projects/#{@project}/jmeter_runs"
  @uri_j = URI.parse @url_j

  run_start( new_run )
end
