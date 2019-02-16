#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require 'test/unit'

require_relative '../bundle/bundler/setup'
require 'repla'

require_relative 'lib/test_data_helper'
require_relative 'lib/test_data_parser'
require_relative 'lib/test_parser_additions'
require_relative 'lib/test_data_tester'

require_relative '../lib/dependencies'
require_relative '../lib/parser'

# Test dependencies
class TestDependencies < Test::Unit::TestCase
  def test_dependencies
    passed = Repla::Search.check_dependencies
    assert(passed, 'The dependencies check should have passed.')
  end
end

# Test parser
class TestParser < Test::Unit::TestCase
  def test_parser
    test_search_output = Repla::Search::Test::TestData.test_search_output
    test_data_directory = Repla::Search::Test::TestData.test_data_directory

    parser = Repla::Search::Parser.new(nil, test_data_directory)
    parser.parse(test_search_output)
    files_hash = parser.files_hash

    test_data_json = Repla::Search::Test::TestData.test_data_json
    test_files_hash = Repla::Search::Test::Parser.parse(test_data_json)

    test_data_tester = Repla::Search::Test::TestDataTester
    file_hashes_match = test_data_tester.test_file_hashes(files_hash,
                                                          test_files_hash)
    assert(file_hashes_match)
  end
end
