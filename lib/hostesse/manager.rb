module Hostesse
  class Manager

    attr_reader :target_file, :base_dir

    def initialize(target_file, base_dir)
      self.target_file = target_file
      self.base_dir    = base_dir
      @template_engine = Hostesse::SimpleTemplateEngine.new(self.base_dir)
    end

    def current_hosts_definition
      if File.exists? target_file
        match = File.read(target_file).split("\n").first
        match = match.match(/^#\s+(.*)/) if match
        if match && ( complete_filename = match[1] ).match(/^#{ base_dir }/)
          complete_filename[base_dir.size.succ...- Hostesse::DEFAULT_HOSTS_FILE_SUFFIX.size]
        else
          nil
        end
      end
    end

    def change_hosts(filename)
      filename = current_hosts_definition if filename.empty?

      if filename
        File.open(target_file, 'w') do |generated_hosts|
          @template_engine.clear
          generated_hosts.write(@template_engine.parse(filename))
        end
      end
    end

    def errors_in_target_file?
      File.read(target_file) =~ /ERROR/ if File.exists? target_file
    end

    def target_file=(target_file)
      @target_file = File.expand_path(target_file)
    end

    def base_dir=(base_dir)
      @base_dir = File.expand_path(base_dir)
    end
  end
end
