module Hostesse
  class SimpleTemplateEngine

    def initialize(base_dir, hosts_file_suffix = Hostesse::DEFAULT_HOSTS_FILE_SUFFIX)
      @base_dir          = File.expand_path base_dir
      @hosts_file_suffix = hosts_file_suffix
      @parsed_files      = {}
    end

    def parse(filename, include_localhost = true)
      complete_filename = complete_filename(filename)

      unless @parsed_files.include? complete_filename
        @parsed_files[complete_filename] = '# ERROR: infinite loop'
        @parsed_files[complete_filename] = prefix(complete_filename, include_localhost) +
                                           content(complete_filename)
      end

      @parsed_files[complete_filename]
    end

    def clear
      @parsed_files.clear
    end

    private

      def complete_filename(filename)
        "#{ @base_dir }/#{ filename }#{ @hosts_file_suffix }"
      end

      def prefix(complete_filename, include_localhost)
        "# #{ complete_filename }\n\n" + (include_localhost ?
          <<-PREFIX.gsub(/^ +/, '')
            127.0.0.1       localhost.localdomain localhost
            ::1             localhost.localdomain localhost
            \n\n
          PREFIX
        : '')
      end

      def resolve_includes(hosts)
        hosts.gsub(/^(.*)\{(.+)\}/) do |include_line|
          if include_line =~ /^\s*#/
            include_line
          else
            parse(include_line.match(/\{(.+)\}/)[1].strip, false)
          end
        end
      end

      def content(complete_filename)
        if File.exists? complete_filename
          resolve_includes(File.read(complete_filename))
        else
          "# ERROR: #{ complete_filename } doesn't exist"
        end
      end
  end
end
