module Hostesse
  class Cli
    class Manager
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
        filename = current_hosts_definition if filename.empty?

        if filename
          File.open(target_file, 'w') do |generated_hosts|
            generated_hosts.write(Hostesse::SimpleTemplateEngine.new(pwd).parse(filename))
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
end
