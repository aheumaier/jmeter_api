desc "Do restful call to Jmeter Server Action"

@project  = "new9"
@platform = "gala.de".to_s.gsub(".", "_")
@env = "webistrano_stage"

#@url_p = "http://service.loadtest.webstage.svc.guj.de:80/api/v1/projects"
@url_p = "http://localhost:3000/api/v1/projects"

#@url_j = "http://service.loadtest.webstage.svc.guj.de:80/api/v1/projects/#{@project}/jmeter_runs"
@url_j = "http://localhost:3000/api/v1/projects/#{@project}/jmeter_runs"

task :run => :environment do
  require 'rubygems'
  require 'net/http'
  require 'json'
  require 'rest_client'
  require_relative '../jmeter_dsl.rb'

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

def create_project(id)
  response = RestClient.post @url_p,
    :content_type => :json,
    :project => {
      :name => "#{id}", :environment => "#{@env}", :platform => "#{@platform}"
    }
  puts "Project created: #{response}"
end

def create_run(description="test_description")
  @jmeter_id = RestClient.post @url_j,
    :content_type => :json,
    :jmeter_run => {
      :jmx_definition_file_id => 1,
      :description => "#{description}",
      :project_id => @project
    }
  puts "Run created! jmeter_id = #{@jmeter_id}"
  @jmeter_id
end

def new_run
  find_or_create_project(@project)
  begin
    create_run('webistrano_run_' + Time.now.to_i.to_s )
  rescue Exception=>e
    raise e
  end
end

def run_start(j_id = @jmeter_id)
  begin
    response = RestClient.get "#{@url_j}/#{j_id}/start"
    puts response
  rescue Exception=>e
    raise e
  end
end

