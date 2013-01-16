require 'test_helper'

class JmeterRunsControllerTest < ActionController::TestCase
  setup do
    @jmeter_run = jmeter_runs(:jone)

  end

  test "should get index" do
    get :index, :project_id=> 1
    assert_response :success
    assert_not_nil assigns(:jmeter_runs)
  end

  test "should get new" do
    get :new, :project_id=> 1
    assert_response :success
  end

  test "should create jmeter_run" do
    assert_difference('JmeterRun.count') do
      post :create, :project_id=> 1, :id => @jmeter_run, :jmeter_run => { :description => @jmeter_run.description,
                                                                          :jmx_file => @jmeter_run.jmx_file, :project_id => @jmeter_run.project_id,
                                                                          :state => @jmeter_run.state }
    end
    assert_redirected_to project_jmeter_runs_path(:project_id => 1)
  end

  test "should show jmeter_run" do
    get :show, :id => @jmeter_run, :project_id=> 1
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @jmeter_run, :project_id=> 1
    assert_response :success
  end

  test "should update jmeter_run" do
    put :update, :project_id=> 1, :id => @jmeter_run, :jmeter_run => { :description => @jmeter_run.description,
                                                                       :jmx_file => @jmeter_run.jmx_file, :project_id => @jmeter_run.project_id, :state => @jmeter_run.state }
    assert_redirected_to project_jmeter_run_path(:project_id=> 1)
  end

  test "should destroy jmeter_run" do
    assert_difference('JmeterRun.count', -1) do
      delete :destroy, :project_id=> 1, :id => @jmeter_run
    end

    assert_redirected_to project_jmeter_runs_path(:project_id=> 1)
  end
end
