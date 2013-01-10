require 'test_helper'

class DefinitionFileTest < ActiveSupport::TestCase

  test "should create definition_file" do
    #df = definition_files(:dfone)
    j0 = nil
    assert_difference('DefinitionFile.count') do
      j0 = DefinitionFile.new(:df => '/home/heuma/testplan.jmx')
      j0.save
    end
    assert_equal 'DefinitionFile', j0.class.to_s
  end
end
