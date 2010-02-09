require 'helper'

class TestSingleInstance < Test::Unit::TestCase

  context "SingleInstance" do
    should "only allow one block for each name" do
      SingleInstance.exclusive_non_blocking(:test) do
        @block_1 = true
        SingleInstance.exclusive_non_blocking(:test) do
          @block_2 = true
        end
      end
      assert @block_1
      assert @block_2.nil?
    end

    should "be able to do something intelligent if it didn't get the lock" do
      SingleInstance.exclusive_non_blocking(:test) do
        SingleInstance.exclusive_non_blocking(:test) do |blocker|
          if blocker
            @no_lock = true
            @blocker = blocker
          else
            @block_2 = true
          end
        end
      end
      assert @block_2.nil?
      assert @no_lock
      assert_equal $$, @blocker.pid
      assert @blocker.started_at < Time.now
      assert @blocker.started_at > (Time.now() - 60)
    end

    should "allow nested blocks with different names" do
      SingleInstance.exclusive_non_blocking(:test1) do
        @block_1 = true
        SingleInstance.exclusive_non_blocking(:test2) do
          @block_2 = true
        end
      end
      assert @block_1
      assert @block_2
    end
  end

end
