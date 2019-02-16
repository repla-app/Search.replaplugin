require 'pathname'

require_relative 'model'
require_relative 'constants'

module Repla
  module Search
    # Parser
    class Parser
      attr_writer :delegate
      def initialize(delegate = nil, directory = nil)
        @delegate = delegate
        @directory = directory
        @files_hash = {}
      end

      def parse_line(output_line)
        metadata_captures = output_line.match(METADATA_REGEXP).captures
        file_path = metadata_captures[0]
        file_path = File.expand_path(file_path)
        if @directory
          directory_path = Pathname.new(@directory)
          relative_base = Pathname.new(file_path)
          display_file_path = relative_base.relative_path_from(
            directory_path
          ).to_s
        end

        file = @files_hash[file_path]
        unless file
          file = Match::File.new(file_path, display_file_path)
          @files_hash[file_path] = file

          @delegate.added_file(file) if @delegate
        end

        line_number = metadata_captures[1].to_i
        line = Match::File::Line.new(line_number)
        file.lines.push(line)

        text = output_line.match(TEXT_REGEXP).captures[0]
        index = 0
        while index && index < text.length
          index = text.index(MATCH_REGEXP)
          next unless index

          matched_text = text.match(MATCH_REGEXP).captures[0]
          text.sub!(MATCH_REGEXP, matched_text)
          length = matched_text.length

          match = Match::File::Line::Match.new(index, length, line)

          line.matches.push(match)
        end
        text.rstrip!

        line.text = text

        @delegate.added_line_to_file(line, file) if @delegate
      end
    end
  end
end
