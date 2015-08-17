require 'test_helper'

module JittokuKnife::Process
  class LazyLockTest < Test::Unit::TestCase
    module FakeModule
      extend LazyLock
    end

    module FakeModule2
      extend LazyLock
    end

    module FakeModule3
      extend LazyLock

      def self.pid_file_name_base
        'fake_module'
      end
    end

    def setup
      JittokuKnife::Process.configure do |config|
        config.pid_dir = File.join(File.dirname(__FILE__), '../../tmp/pids')
      end
      @pids_file_path = JittokuKnife::Process.config.pid_dir
    end

    def teardown
      FakeModule.lock_end
      FakeModule2.lock_end
      FakeModule3.lock_end
    end

    def test_pid_file_name
      assert_equal 'fake_module', FakeModule.pid_file_name_base
      assert_equal 'fake_module2', FakeModule2.pid_file_name_base
      assert_equal 'fake_module', FakeModule3.pid_file_name_base
    end

    def test_pid_file_name_with_ext
      assert_not_nil 'fake_module.pid', FakeModule.pid_file_name
    end

    def test_current_pid
      assert_equal $$, FakeModule.current_pid
    end

    def test_locking
      FakeModule.lock_start
      assert_true FakeModule.running?
      FakeModule.lock_end
      assert_false FakeModule.running?
    end

    def test_locking2
      FakeModule.lock_start
      assert_false FakeModule2.running?
    end

    def test_use_same_locking
      FakeModule.lock_start
      assert_true FakeModule3.running?
    end
  end
end