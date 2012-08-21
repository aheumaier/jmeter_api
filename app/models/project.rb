class Project < ActiveRecord::Base

  has_many :jmeter_runs, :dependent => :destroy, :order => :updated_at
  has_one :setting, :dependent=> :nullify

  attr_accessible :environment, :name, :jmeter_runs_attributes
  accepts_nested_attributes_for :jmeter_runs, :allow_destroy => true

  before_save :create_settings

  def create_settings
    if self.setting == nil
      self.build_setting
    end
  end

  def self.find_by_param(id)
    if id.match(/^[\d]+(\.[\d]+){0,1}$/)
      Project.find_by_id(id)
    else
      Project.find_by_name(id)
    end
  end

end
