require 'test_helper'
require 'pp'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = projects(:pone)
  end

  test "fixtures_project_count" do
    assert_equal 2, Project.count
  end

  test "should not save project without name " do
    p0 = Project.new
    assert !p0.save, "Saved the Project without any attributes"
  end

  test "should save with project attributes" do
    p1 = Project.new( :environment => 'dev' )
    assert !p1.save, "Saved the Project without a name"
    p1 = Project.new( :name => 'testproject' )
    assert !p1.save, "Saved the Project without a environment"
    p1 = Project.new(:name => 'testproject', :environment => 'dev' )
    assert p1.save, "Could not save the Project with a title"
  end

  test "should have settings" do
    p2 = Project.new(:name => 'testproject', :environment => 'dev', :platform => 'testplatform' )
    p2.save
    assert_respond_to  p2, :setting, "Saved the Project without creating settings"
  end

  test "should find by param" do
    p3_s = Project.find_by_param('MyString1')
    p3_i = Project.find_by_param(@project.id)
    assert_equal p3_s, p3_i , 'Find different Projects by string and int'
  end

end
