# coding: utf-8

require 'test_helper'

module JittokuKnife::Process
  class ConfigTest < Test::Unit::TestCase
    def test_config
      assert_not_nil JittokuKnife::Process.config
      assert_equal '/tmp', JittokuKnife::Process.config.pid_dir
    end

    def test_configure
      JittokuKnife::Process.configure do |config|
        config.pid_dir = '/tmp/pids'
      end
      assert_equal '/tmp/pids', JittokuKnife::Process.config.pid_dir
    end
  end
end