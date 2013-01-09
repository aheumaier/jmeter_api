require 'helper'

class TestStacktest < MiniTest::Unit::TestCase

  def test_plan_should_respond_to_thread_groups
    test do
       assert_equal(true, self.respond_to?(:threads),  '######### test plan does not repond to thread #########')
    end
  end

  def test_plan_should_respond_to_transaction
    test do
      assert_equal(true, self.respond_to?(:transaction),  '######### does not repond to transaction #########')
    end
  end

  def test_plan_should_respond_to_visit
    test do
      assert_equal(true, self.respond_to?(:visit),  '######### does not repond to visit #########')
    end
  end

  def test_plan_should_respond_to_submit
    test do
      assert_equal(true, self.respond_to?(:submit),  '######### does not repond to submit #########')
    end
  end

  #def test_plan_should_output_testplan
  #  assert_output("</jmeterTestPlan>") {
  #    test do
  #
  #    end }
  #end

  #describe "DSL" do

  #
  #  it "should output a test plan to stdout" do
  #    $stdout.should_receive(:puts).with(/jmeterTestPlan/i)
  #    test do
  #    end.jmx
  #  end
  #
  #  it "should output a test plan to jmx file" do
  #    file = mock('file')
  #    File.should_receive(:open).with("/tmp/jmeter.jmx", "w").and_yield(file)
  #    file.should_receive(:write).with(/jmeterTestPlan/i)
  #    test do
  #    end.jmx
  #  end
  #
  #end

  def test_run_with_all_params
    test do
      threads.100 do
        visit 'www.google.de'
      end
    end.run {
      :jmeter_path=''

    }

  end

end
