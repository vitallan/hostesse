require 'hostesse/cli/messages'

module Hostesse
  class Cli
    attr_reader :target_file, :pwd

    def current_hosts_definition
      match = File.read(target_file).split("\n").first.match(/^#\s+(.*)/)
      if match && ( complete_filename = match[1] ).match(/^#{ pwd }/)
        complete_filename[(pwd.size.succ)...(- Hostesse::DEFAULT_HOSTS_FILE_SUFFIX.size)]
      else
        nil
      end
    end

    def initialize(target_file, pwd)
      self.target_file = target_file
      self.pwd         = pwd
    end

    def target_file=(target_file)
      @target_file = File.expand_path(target_file)
    end

    def pwd=(pwd)
      @pwd = File.expand_path(pwd)
    end

    def at_exit
      puts Hostesse::Cli::Messages.exit
      Kernel.exit!
    end
  end
end
