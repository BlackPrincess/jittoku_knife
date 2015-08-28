# coding: utf-8

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

require "test-unit"
require "test/unit/notify"
require 'simplecov'

if !!ENV['CI']
  require 'coveralls'
  Coveralls.wear!
  
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    add_filter '.bundle/'
  end
end

require 'jittoku_knife'

$LOAD_PATH.unshift(lib_dir)
$LOAD_PATH.unshift(test_dir)