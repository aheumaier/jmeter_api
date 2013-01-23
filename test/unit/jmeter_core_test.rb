require 'test_helper'


class TestJmeterCore < MiniTest::Unit::TestCase
  def setup
    @params_hash = {"jprop_accesslog"=>"mobile.eltern.de.20110426_21-22.log", "jprop_counter"=>1, "jprop_period"=>3600, "jprop_threads"=>20, "jprop_throughput"=>600, "jprop_jmx"=>"testplan.jmx", "jprop_jtl"=>"jmeter_run_log_1358948262.jtl", "jprop_remote_server"=>nil}
  end

  def test_should_create_jmetercore_object
    jmeter_core_inst = JmeterDsl::Jmeter::JmeterCore.new(@params_hash)
    assert_equal 'JmeterDsl::Jmeter::JmeterCore', jmeter_core_inst.class.to_s
  end

  def test_jmtercore_output_build_string
    jmeter_core_inst = JmeterDsl::Jmeter::JmeterCore.new(@params_hash)
    jmeter_core_inst.runner
    assert true

  end


end
