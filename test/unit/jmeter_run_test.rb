require 'test_helper'
require 'pp'

class JmeterRunTest < ActiveSupport::TestCase

  test "should not save jmeter_run without description" do
    j0 = JmeterRun.new
    assert !j0.push_start, "Saved the JmeterRun without any attributes"
    assert_equal 'idle',j0.state, 'State hast changed: should be idle '
  end

  test "should have a project" do
    j1 = jmeter_runs(:jone)
    assert_respond_to  j1, :project, "Saved the JmeterRun without having a project"
    assert_equal 'MyString1', j1.project.name
  end

  test "should create jmeter_run" do
    project = projects(:pone)
    j0 = nil
    assert_difference('JmeterRun.count') do
      j0 = JmeterRun.new(:description => 'Some test description')
      j0.save
    end
    assert_equal 'JmeterRun', j0.class.to_s
    assert_equal 'idle', j0.state, 'Wrong initial State'
  end

  test "should queue delayed_job" do
    project = projects(:pone)
    jmeter_run = project.jmeter_runs.create(:description => 'first testrun', :jmx_source => 'http://here/is/my/code/1')
    assert_difference('Delayed::Job.count') do
      jmeter_run.push_start
    end
  end

end
