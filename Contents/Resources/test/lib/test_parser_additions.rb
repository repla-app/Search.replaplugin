require_relative '../../lib/parser'

module Repla::Search
  class Parser
    attr_reader :files_hash
    def parse(data)
      data.each_line do |line|
        parse_line(line)
      end
    end
  end
end
