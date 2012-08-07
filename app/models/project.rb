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

end
