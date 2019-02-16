require_relative '../bundle/bundler/setup'
require 'repla/dependencies'

module Repla
  # Search
  module Search
    def self.check_dependencies
      dependency_pwd = Repla::Dependencies::Dependency.new('pwd',
                                                           :shell_command)
      dependency_grep = Repla::Dependencies::Dependency.new('grep',
                                                            :shell_command)
      checker = Repla::Dependencies::Checker.new
      checker.check_dependencies([dependency_grep, dependency_pwd])
    end
  end
end
