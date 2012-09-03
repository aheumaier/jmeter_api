require 'test_helper'

class SettingTest < ActiveSupport::TestCase

  setup do
    @project = projects(:pone)
    @setting = settings(:sone)
  end

  test "should set default properties" do
    p1 = Project.create(:name => 'testproject', :environment => 'dev', :platform => 'testplatform' )
    if p1.save!
      assert_kind_of String, p1.setting.jmeter_accesslog
      assert_equal 1, p1.setting.jmeter_counter
      assert_equal 3600, p1.setting.jmeter_period
      assert_equal 4, p1.setting.jmeter_threads
      assert_equal 600, p1.setting.jmeter_troughput
      assert_kind_of String, p1.setting.jmx_file
      assert !p1.setting.jmx_file.empty?
      assert_kind_of String, p1.setting.jtl_file
      assert !p1.setting.jtl_file.empty?
      assert_kind_of String, p1.setting.remote_server
      assert_kind_of String, p1.setting.ext_opts
    end
  end

  test "should overide defaults on update" do


  end

end
