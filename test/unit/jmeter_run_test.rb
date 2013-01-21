require 'test_helper'
require 'pp'

class JmeterRunTest < ActiveSupport::TestCase

  #test "should not save jmeter_run without jmx file" do
  #  j0 = j0 = JmeterRun.new(:description => 'Some test description')
  #  if j0.save!
  #  assert
  #
  #  assert !j0.push_start, "Saved the JmeterRun without any attributes"
  #  assert_equal 'idle',j0.state, 'State hast changed: should be idle '
  #  end
  #end
  #
  #test "should not save jmeter_run without jtl file" do
  #  j0 = JmeterRun.new
  #  assert !j0.push_start, "Saved the JmeterRun without any attributes"
  #  assert_equal 'idle',j0.state, 'State hast changed: should be idle '
  #end

  test "should not save jmeter_run without project_id" do
    assert_raise ActiveRecord::RecordInvalid do
      j0 = JmeterRun.new
      j0.save!
    end

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
      j0 = JmeterRun.new( :project_id => 1)
      j0.save!
    end
    assert_equal 'JmeterRun', j0.class.to_s
    assert_equal 'default jmeter run description. CHANGE ME',j0.description, "Saved the JmeterRun withoutout
setting defaults"
    assert_equal 'idle',j0.state, 'State hast changed: should be idle '
    assert_equal false,j0.locked, 'Lock hast changed: should be false '
    assert_equal 1,j0.jmeter_counter, 'Counter hast changed: should be 1 '
    assert_equal 3600,j0.jmeter_period, 'Duration hast changed: should be 3600 '
    assert_equal 20, j0.jmeter_threads, 'Threads has changed: should be 20'
  end

  test "should queue delayed_job" do
    project = projects(:pone)
    jmeter_run = project.jmeter_runs.create(:description => 'first testrun', :jmx_file => '/here/is/my/code/1')
    assert_difference('Delayed::Job.count') do
      jmeter_run.push_start
    end
  end

end
