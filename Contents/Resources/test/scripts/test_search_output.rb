#!/usr/bin/env ruby --disable-gems

require 'Shellwords'

# Declare the module otherwise importing "grep_constants.rb" will fail
module Repla
end

require_relative '../lib/test_script_constants'
require_relative '../../lib/constants'

command = "#{SEARCH_COMMAND} \"#{SEARCH_TERM}\" "\
  "#{Shellwords.escape(TEST_DATA_DIRECTORY)}"
result = `#{command}`
puts result
