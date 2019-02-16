SEARCH_COMMAND = 'ack --color --nogroup'.freeze

module Repla
  module Search
    class Parser
      ANSI_ESCAPE = '\x1b[^m]*m'.freeze
      MATCH_REGEXP = Regexp.new("#{ANSI_ESCAPE}(.+?)#{ANSI_ESCAPE}")
      METADATA_REGEXP = Regexp.new(
        MATCH_REGEXP.source + ":#{ANSI_ESCAPE}([0-9]+)#{ANSI_ESCAPE}:"
      )
      LINE_ENDING = ANSI_ESCAPE.to_s + '\x1b\[K'
      TEXT_REGEXP = Regexp.new(
        "#{ANSI_ESCAPE}.+?#{ANSI_ESCAPE}:#{ANSI_ESCAPE}"\
        "[0-9]+#{ANSI_ESCAPE}:(.*?)#{LINE_ENDING}"
      )
    end
  end
end
