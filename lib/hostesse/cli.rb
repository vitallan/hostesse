require 'readline'

require 'hostesse'
require 'hostesse/cli/messages'

module Hostesse
  class Cli
    def initialize
      @manager  = Hostesse::Manager.new(ARGV[0] || Hostesse::Environment.default_target_file, '.')
      @messages = Hostesse::Cli::Messages.new(@manager)

      trap('INT') { exit } # handle ctrl+c

      Readline.completion_append_character = ''
      Readline.completion_proc             = ->(s) {
        Dir[s + '*'].map { |inode|
          if File.directory? inode
            inode + '/'
          elsif inode =~ /#{ Regexp.quote(Hostesse::DEFAULT_HOSTS_FILE_SUFFIX) }$/
            inode[0..-Hostesse::DEFAULT_HOSTS_FILE_SUFFIX.size.succ]
          else
            nil
          end
        }.compact
      }

      puts @messages.welcome
    end

    def main_loop
      loop do
        line = Readline.readline(@messages.ps1, true)

        exit unless line

        begin
          if @manager.change_hosts(line.strip)
            puts @messages.change_hosts
          end
        rescue Errno::EACCES
          puts @messages.error_target_file_isnt_writable
        rescue => error
          puts @messages.error_very_bad_error(error)
        end
      end
    end

    private

      def exit
        Kernel.abort Hostesse::Cli::Messages.exit
      end
  end
end
