require 'rbconfig'

module Hostesse
  module Cli
    class Environment
      class << self
        # thanks StackOverflow
        # http://stackoverflow.com/questions/4871309/what-is-the-correct-way-to-detect-if-ruby-is-running-on-windows
        def is_windows?
          @is_windows ||= RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
        end

        def is_jruby?
          @is_jruby ||= RUBY_PLATFORM == 'java'
        end

        def default_target_file
          @default_target_file ||= is_windows? ? 'C:/windows/system32/drivers/etc/hosts' : '/etc/hosts'
        end
      end
    end
  end
end
