require 'rubygems'
require 'fileutils'

class Project < ActiveRecord::Base

  has_many :jmeter_runs, :dependent => :destroy, :order => :updated_at, :autosave => true
  has_one :setting, :dependent=> :nullify

  attr_accessible :environment, :name, :jmeter_runs_attributes, :setting_attributes, :reports_home , :platform
  accepts_nested_attributes_for :jmeter_runs, :allow_destroy => true
  accepts_nested_attributes_for :setting, :allow_destroy => true

  validates_presence_of :name, :environment, :platform

  before_save :create_settings

  def create_settings
    if self.setting == nil
      self.build_setting
      self.save!
    end
  end

  def self.find_by_param(id)
    if id.to_s.match(/^[\d]+(\.[\d]+){0,1}$/)
      Project.find_by_id(id)
    else
      Project.find_by_name(id)
    end
  end

  def find_or_create_reports_home(params)
    reports_home_path = "/app1/jmeter/reports/" + params[:platform] + "/" + params[:environment] + "/"
    if File.directory?( reports_home_path )
      self.reports_home = reports_home_path
    else
      FileUtils.mkdir_p reports_home_path
      self.reports_home = reports_home_path
    end
  end

end
