desc "Do restful call to Jmeter Server Action"

#@platform = platform || "gala.de".to_s.gsub(".", "_")
#@project  = project || "new"

@platform = "gala.de".to_s.gsub(".", "_")
@project  = "new4"

#@url_p = "http://service.loadtest.webstage.svc.guj.de:80/api/v1/projects"
@url_p = "http://localhost:3000/api/v1/projects"
@uri_p = URI.parse @url_p

#@url_j = "http://service.loadtest.webstage.svc.guj.de:80/api/v1/projects/#{@project}/jmeter_runs"
@url_j = "http://localhost:3000/api/v1/projects/#{@project}/jmeter_runs"
@uri_j = URI.parse @url_j

task :run => :environment do
  require 'rubygems'
  require 'net/http'
  require 'json'
  require 'rest_client'
  require '../jmeter_api/lib/jmeter-dsl/dsl.rb'

  run_start( new_run )
end

def find_or_create_project(id=nil)
  begin
    if Project.find_by_param(id).nil?
      puts "Project not found but will be created."
      create_project(id)
    else
      puts "Project found."
    end
  rescue Exception=>e
    raise e
  end
end

def read_project(id=nil)
  puts "Reading project..."
  if id.nil?
    response = RestClient.get "http://#{@uri_p.host}:#{@uri_p.port}#{@uri_p.path}.json"
  else
    response = RestClient.get "http://#{@uri_p.host}:#{@uri_p.port}#{@uri_p.path}/#{id}.json"
  end
  return response.body
end

def create_project(id)
  response = RestClient.post "http://#{@uri_p.host}:#{@uri_p.port}#{@uri_p.path}",
    :content_type => :json,
    :project => {
    :name => "#{id}", :environment => "webistrano_stage", :platform => "#{@platform}"
  }
  puts "Project created: #{response}"
end

def create_run(description="test_description")
  @jmeter_id = RestClient.post "http://#{@uri_j.host}:#{@uri_j.port}#{@uri_j.path}",
    :content_type => :json,
    :description => "#{description}",
    :project_id => @project,
    :jmeter_run => {
    :jmx_definition_file_id => 1,
    :description => "#{description}",
    :project_id => @project
  }
  puts "Run created! jmeter_id = #{@jmeter_id}"
  @jmeter_id
end

def new_run
  puts "="*40
  find_or_create_project(@project)
  begin
    create_run('webistrano_run_' + Time.now.to_i.to_s )
  rescue Exception=>e
    raise e
  end
end

def run_start(j_id = @jmeter_id)
  begin
    response = RestClient.get "http://#{@uri_j.host}:#{@uri_j.port}#{@uri_j.path}/#{j_id}/start"
    puts response
  rescue Exception=>e
    raise e
  end
end

