require 'rubygems'
require 'fileutils'

class Project < ActiveRecord::Base
  attr_accessible :environment, :name, :jmeter_runs_attributes, :setting_attributes, :reports_home , :platform

  has_many :jmeter_runs, :dependent => :destroy, :order => :updated_at, :autosave => true
  accepts_nested_attributes_for :jmeter_runs, :allow_destroy => true

  validates_presence_of :name, :environment, :platform

  def self.find_by_param(id)
    if id.to_s.match(/^[\d]+(\.[\d]+){0,1}$/)
      Project.find_by_id(id)
    else
      Project.find_by_name(id)
    end
  end

  def find_or_create_reports_home(params)
    reports_home_path = "/app1/jmeter/reports/" + params[:platform] + "/" + params[:name] + "/" + params[:environment] + "/"
    Rails.logger.debug reports_home_path
    if File.directory?( reports_home_path )
      self.reports_home = reports_home_path
    else
      FileUtils.mkdir_p reports_home_path
      self.reports_home = reports_home_path
    end
  end

end
