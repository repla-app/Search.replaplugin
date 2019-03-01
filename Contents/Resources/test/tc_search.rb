#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require 'minitest/autorun'
require 'Shellwords'

require_relative '../bundle/bundler/setup'
require 'repla/test'
require Repla::Test::HELPER_FILE
require Repla::Test::REPLA_FILE

require_relative 'lib/test_data_helper'
require_relative 'lib/test_data_parser'
require_relative 'lib/test_javascript_helper'
require_relative 'lib/test_data_tester'

require_relative '../lib/dependencies'

# Test dependencies
class TestDependencies < Minitest::Test
  def test_dependencies
    passed = Repla::Search.check_dependencies
    assert(passed, 'The dependencies check should have passed.')
  end
end

# Test search
class TestSearch < Minitest::Test
  SEARCH_FILE = File.join(File.dirname(__FILE__), '..', 'search.rb')
  def test_controller
    test_data_directory = Repla::Search::Test::TestData.test_data_directory
    test_search_term = Repla::Search::Test::TestData.test_search_term
    command = "#{Shellwords.escape(SEARCH_FILE)} \"#{test_search_term}\""\
      " #{Shellwords.escape(test_data_directory)}"
    `#{command}`

    window_id = Repla::Test::Helper.window_id
    window = Repla::Window.new(window_id)

    javascript_helper = Repla::Search::Test::JavaScriptHelper
    files_json = javascript_helper.files_hash_for_window_manager(window)
    files_hash = Repla::Search::Test::Parser.parse(files_json)

    test_data_json = Repla::Search::Test::TestData.test_data_json
    test_files_hash = Repla::Search::Test::Parser.parse(test_data_json)

    testdata_tester = Repla::Search::Test::TestDataTester
    file_hashes_match = testdata_tester.test_file_hashes(files_hash,
                                                         test_files_hash)
    assert(file_hashes_match)

    window.close
  end
end
