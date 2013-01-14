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
    assert !p1.save, "Could not save the Project without a platform"
    p1 = Project.new(:name => 'testproject', :environment => 'dev', :platform => 'testplatform' )
    assert p1.save, "Could not save the Project with a title"
  end

  test "should find by param" do
    p3_s = Project.find_by_param('MyString1')
    p3_i = Project.find_by_param(@project.id)
    assert_equal p3_s, p3_i , 'Find different Projects by string and int'
  end

  test "should set reports_home_path" do
    p1 = Project.create(:name => 'testproject', :environment => 'dev', :platform => 'testplatform' )
    assert p1.save!, "Could not save the Project..."
    p1.find_or_create_reports_home(:name => 'testproject', :environment => 'dev', :platform => 'testplatform')
    assert_equal "/app1/jmeter/reports/" + p1.platform + "/"  + p1.name + "/" + p1.environment + "/",
                 p1.reports_home, 'Find different Projects reports path '
    puts  p1.reports_home
    assert File.exist?( p1.reports_home)

  end



end
