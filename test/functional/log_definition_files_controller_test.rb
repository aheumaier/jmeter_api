require 'test_helper'

class LogDefinitionFilesControllerTest < ActionController::TestCase
  setup do
    @log_definition_file = log_definition_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_definition_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_definition_file" do
    assert_difference('LogDefinitionFile.count') do
      post :create, log_definition_file: {  }
    end

    assert_redirected_to log_definition_file_path(assigns(:log_definition_file))
  end

  test "should show log_definition_file" do
    get :show, id: @log_definition_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log_definition_file
    assert_response :success
  end

  test "should update log_definition_file" do
    put :update, id: @log_definition_file, log_definition_file: {  }
    assert_redirected_to log_definition_file_path(assigns(:log_definition_file))
  end

  test "should destroy log_definition_file" do
    assert_difference('LogDefinitionFile.count', -1) do
      delete :destroy, id: @log_definition_file
    end

    assert_redirected_to log_definition_files_path
  end
end
