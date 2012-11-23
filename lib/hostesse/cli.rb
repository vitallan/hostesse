require 'hostesse/cli/messages'

module Hostesse
  class Cli
    attr_reader :target_file, :pwd

    def initialize(target_file, pwd)
      self.target_file = target_file
      self.pwd         = pwd
    end

    def current_hosts_definition
      match = File.read(target_file).split("\n").first.match(/^#\s+(.*)/)
      if match && ( complete_filename = match[1] ).match(/^#{ pwd }/)
        complete_filename[(pwd.size.succ)...(- Hostesse::DEFAULT_HOSTS_FILE_SUFFIX.size)]
      else
        nil
      end
    end

    def change_hosts(filename)
      ''.tap do |parsed_hosts|
        File.open(target_file, 'w') do |generated_hosts|
          parsed_hosts = Hostesse::SimpleTemplateEngine.new(pwd).parse(filename)
          generated_hosts.write(parsed_hosts)
        end
      end
    end

    def errors_in_target_file?
      File.read(target_file) =~ /ERROR/
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
