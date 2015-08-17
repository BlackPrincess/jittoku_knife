base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

require "test-unit"
require "test/unit/notify"

require 'jittoku_knife'

$LOAD_PATH.unshift(lib_dir)
$LOAD_PATH.unshift(test_dir)