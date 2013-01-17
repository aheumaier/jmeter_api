require 'test_helper'

class Api::V1::JmxDefinitionFilesControllerTest < ActionController::TestCase
  setup do
    @jmx_definition_file = jmx_definition_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jmx_definition_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jmx_definition_file" do
    assert_difference('JmxDefinitionFile.count') do
      post :create, jmx_definition_file: {  }
    end

    assert_redirected_to jmx_definition_file_path(assigns(:jmx_definition_file))
  end

  test "should show jmx_definition_file" do
    get :show, id: @jmx_definition_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jmx_definition_file
    assert_response :success
  end

  test "should update jmx_definition_file" do
    put :update, id: @jmx_definition_file, jmx_definition_file: {  }
    assert_redirected_to jmx_definition_file_path(assigns(:jmx_definition_file))
  end

  test "should destroy jmx_definition_file" do
    assert_difference('JmxDefinitionFile.count', -1) do
      delete :destroy, id: @jmx_definition_file
    end

    assert_redirected_to jmx_definition_files_path
  end
end
