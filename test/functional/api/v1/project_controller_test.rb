require 'test_helper'

class Api::V1::ProjectControllerTest < ActionController::TestCase
  #fixtures :projects

  setup do
    @controller = ProjectController.new
  end

  test "should get index" do
    get :index
    assert_response :success
    #assert_not_nil assigns(:projects)
  end

  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end
  #
  #test "should create project" do
  #  assert_difference('Project.count') do
  #    post :create, :project => { :environment => @project.environment, :name => @project.name,
  #                                :platform => 'testplatform'  }
  #  end
  #
  #  assert_equal "/app1/jmeter/reports/" + @project.platform + "/" + @project.name + "/" + @project.environment + "/",
  #               Project.last.reports_home
  #  assert_redirected_to project_path(assigns(:project))
  #end
  #
  #test "should show project" do
  #  get :show, :id => @project
  #  assert_response :success
  #end
  #
  #test "should get edit" do
  #  get :edit, :id => @project
  #  assert_response :success
  #end
  #
  #test "should update project" do
  #  put :update, :id => @project, :project => { :environment => @project.environment, :name => @project.name }
  #  assert_redirected_to project_url(assigns(:project)) or assert_response :success
  #end
  #
  #test "should destroy project" do
  #  assert_difference('Project.count', -1) do
  #    delete :destroy, :id => @project
  #  end
  #
  #  assert_redirected_to projects_path
  #end

end
