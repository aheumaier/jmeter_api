require 'test_helper'


class TestJmeterDsl < MiniTest::Unit::TestCase

  def test_plan_should_respond_to_thread_groups
    jmetertest do
      assert_equal(true, self.respond_to?(:threads),  '######### test plan does not repond to thread #########')
    end
  end

  def test_plan_should_respond_to_transaction
    jmetertest do
      assert_equal(true, self.respond_to?(:transaction),  '######### does not repond to transaction #########')
    end
  end

  def test_plan_should_respond_to_visit
    jmetertest do
      assert_equal(true, self.respond_to?(:visit),  '######### does not repond to visit #########')
    end
  end

  def test_plan_should_respond_to_submit
    jmetertest do
      assert_equal(true, self.respond_to?(:submit),  '######### does not repond to submit #########')
    end
  end

  #def test_plan_should_raise_no_errors
  #    jmetertest do
  #      threads 10 do
  #        visit 'Google Search', 'http://google.com'
  #      end
  #    end.run.wont_raise Exeption => e
  #end

end
