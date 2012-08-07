#!/usr/bin/ruby 
require 'net/http'
require 'uri'
require 'active_support'

def find_or_create_project(project_name)
  begin 
    puts 'find_or_create_project called with ' + project_name
    url = URI.parse('http://localhost:3000')
    res = Net::HTTP.start(url.host, url.port) { |http| http.get("/projects/#{project_name}.json") }
    if res == 'Entry not found'
     
     false
     puts 'Entry not found but created'
    else
      true
      puts 'Entry found'
    end
  rescue Exception=>e 
    raise e
  end
end

def new_run
  puts 'calling find_or_create'
  find_or_create_project(@project)
  puts 'add run'
    begin 
      url = URI.parse('http://localhost:3000')
      res = Net::HTTP.start(url.host, url.port) { |http| http.get("/projects/#{@project}/addrun") }
    rescue Exception=>e 
      raise e
    end
end

def run_start(jmeter_id)
  puts 'start run called'
  begin
    url = URI.parse('http://localhost:3000')          
    puts Net::HTTP.start(url.host, url.port) { |http| http.get("/projects/#{@project}/jmeter_runs/#{jmeter_id}/status") }
  rescue Exception=>e 
    raise e
  end
end

begin
  @project = "imageGalaDe" #.gsub(".", "_").camelize
  run_start( new_run )
end
