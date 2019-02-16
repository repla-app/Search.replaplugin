module Repla
  module Search
    module Match
      # File
      class File
        attr_reader :file_path, :display_file_path, :lines
        def initialize(file_path, display_file_path = nil)
          @file_path = file_path
          @display_file_path = display_file_path || file_path
          @lines = []
        end

        # Line
        class Line
          attr_reader :number, :matches
          attr_accessor :text
          def initialize(number)
            @number = number
            @matches = []
          end

          # Match
          class Match
            attr_reader :index, :length
            def initialize(index, length, line)
              @index = index
              @length = length
              @line = line
            end

            def text
              @line.text[index..(index + length - 1)]
            end
          end
        end
      end
    end
  end
end
