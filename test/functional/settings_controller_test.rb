require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  setup do
    @setting = settings(:sone)
  end

  test "should get index" do
    get :index, :project_id=> 1
    assert_response :success
    assert_not_nil assigns(:settings)
  end

  test "should show setting" do
    get :show, :id => @setting, :project_id=> 1
    assert_response :success
  end

  #test "should get new" do
  #  get :new, :project_id=> 1
  #  assert_response :success
  #end

  #test "should create setting" do
  #  assert_difference('Setting.count') do
  #    post :create,:id => @setting, :project_id=> 1, :setting => { :jmeter_accesslog => @setting.jmeter_accesslog,
  #                                                  :jmeter_counter => @setting.jmeter_counter, :jmeter_period => @setting.jmeter_period, :jmeter_threads => @setting.jmeter_threads, :jmeter_troughput => @setting.jmeter_troughput, :jmx_file => @setting.jmx_file, :jtl_file => @setting.jtl_file, :remote_server => @setting.remote_server }
  #  end
  #
  #  assert_redirected_to project_setting_path(assigns(:setting), :project_id=> 1)
  #end



  test "should get edit" do
    get :edit, :id => @setting, :project_id=> 1
    assert_response :success
  end

  test "should update setting" do
    put :update, :id => @setting, :project_id=> 1, :setting => { :jmeter_accesslog => @setting.jmeter_accesslog,
                                                                 :jmeter_counter => @setting.jmeter_counter, :jmeter_period => @setting.jmeter_period, :jmeter_threads => @setting.jmeter_threads, :jmeter_troughput => @setting.jmeter_troughput, :jmx_file => @setting.jmx_file, :jtl_file => @setting.jtl_file, :remote_server => @setting.remote_server }
  assert_redirected_to project_setting_path(assigns(:setting), :project_id=> 1)
  end

  test "should destroy setting" do
    assert_difference('Setting.count', -1) do
      delete :destroy, :id => @setting, :project_id=> 1
    end

    assert_redirected_to project_settings_path(:project_id=> 1)
  end
end
