require_relative '../../bundle/bundler/setup'
require 'repla'

module Repla::Search
  module Test
    module JavaScriptHelper
      JAVASCRIPT_DIRECTORY = File.join(File.dirname(__FILE__), '..', 'js')
      DOMTOJSON_JAVASCRIPT_FILE = File.join(JAVASCRIPT_DIRECTORY, 'dom_to_json.js')
      def self.files_hash_for_window_manager(window_manager)
        javascript = File.read(DOMTOJSON_JAVASCRIPT_FILE)
        window_manager.do_javascript(javascript)
      end
    end
  end
end
