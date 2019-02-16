require_relative 'view'
require_relative 'model'

module Repla::Search
  class Controller < Repla::Controller

    def initialize
      @view = View.new
    end

    def added_file(file)
      @view.add_file(file.file_path, file.display_file_path)
    end

    def added_line_to_file(line, file)
      matches = line.matches
      line_number = line.number
      text = line.text
      @view.add_line(line_number, text, matches)
    end

  end
end
