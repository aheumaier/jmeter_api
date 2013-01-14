require 'test_helper'

class JmeterSettingTest < ActiveSupport::TestCase

  setup do
    @project = projects(:pone)
    #@jmeter_setting = jmeter_settings(:sone)
  end

  test "should set default properties" do
    p1 = Project.create(:name => 'testproject', :environment => 'dev', :platform => 'testplatform' )
    jr1 = p1.jmeter_runs.create(:description => 'this_is_a_test_decription')
    if p1.save!
      assert_kind_of String, jr1.jmeter_setting.jmeter_accesslog
      assert_equal 1, jr1.jmeter_setting.jmeter_counter
      assert_equal 3600, jr1.jmeter_setting.jmeter_period
      assert_equal 20, jr1.jmeter_setting.jmeter_threads
      assert_equal 600, jr1.jmeter_setting.jmeter_troughput
      assert_kind_of String, jr1.jmeter_setting.jmx_file
      #assert !jr1.jmeter_setting.jmx_file.empty?
      assert_kind_of String, jr1.jmeter_setting.jtl_file
      assert !jr1.jmeter_setting.jtl_file.empty?
      assert_kind_of String, jr1.jmeter_setting.remote_server
      assert_kind_of String, jr1.jmeter_setting.ext_opts
    end
    pp jr1.jmeter_setting.jmx_file
  end



  test "should overide defaults on update" do


  end

end
