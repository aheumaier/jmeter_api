class Project < ActiveRecord::Base
  attr_accessible :environment, :name

  has_many :jmeter_runs, :dependent => :destroy, :order => :updated_at
  has_one :setting, :dependent=> :nullify

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
