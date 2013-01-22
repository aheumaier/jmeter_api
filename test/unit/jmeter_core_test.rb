require 'test_helper'


class TestJmeterCore < MiniTest::Unit::TestCase
  def setup
    @params_hash = {"jmeter_accesslog"=>"www.eltern.de.20110426_21-22.log", "jmeter_counter"=>1, "jmeter_period"=>3600, "jmeter_threads"=>20, "jmeter_troughput"=>600, "jmx_file"=>"testplan.jmx", "jtl_file"=>"jmeter_run_log_1358787193.jtl", "jmx_definition_file_id"=>5}
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
