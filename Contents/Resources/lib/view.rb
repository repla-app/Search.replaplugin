require_relative '../bundle/bundler/setup'
require 'repla'
require 'repla/lib/escape'

require_relative 'model'


module Repla::Search
  class View < Repla::View
    using Escape
    ROOT_ACCESS_DIRECTORY = File.join(File.dirname(__FILE__), '../html')
    VIEW_TEMPLATE = File.join(ROOT_ACCESS_DIRECTORY, 'index.html')


    def initialize
      super
      self.root_access_directory_path = File.expand_path(
        ROOT_ACCESS_DIRECTORY
      )
      load_file(VIEW_TEMPLATE)
    end

    ADD_FILE_JAVASCRIPT_FUNCTION = "addFile"
    def add_file(file_path, display_file_path)
      do_javascript_function(ADD_FILE_JAVASCRIPT_FUNCTION, [file_path, display_file_path])
    end
    
    def add_line(line_number, text, matches)
      matches_javascript = self.class.matches_javascript(matches)      
      text.javascript_escape!
      javascript = %Q[
#{matches_javascript}
addLine(#{line_number}, '#{text}', matches);
]
      do_javascript(javascript)
    end

    private

    def self.matches_javascript(matches)
      matches_json = ""
      matches.each { |match|
        match_json = %Q[ 
  {
    index: #{match.index},
    length: #{match.length}
  },]
        matches_json << match_json
      }
      matches_json.chomp!(",");
      %Q[
var matches = [#{matches_json}  
];
]
    end

  end
end
