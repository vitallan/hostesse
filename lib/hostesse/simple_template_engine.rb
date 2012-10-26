module Hostesse

  class SimpleTemplateEngine

    def initialize(base_path, hosts_file_suffix = '.hosts')
      @base_path         = File.expand_path base_path
      @hosts_file_suffix = hosts_file_suffix
    end

    def parse(filename)
      complete_filename = complete_filename(filename)
      prefix(complete_filename) + if File.exists? complete_filename
                                    resolve_includes(File.read(complete_filename))
                                  else
                                    "# ERROR: #{ complete_filename } doesn't exist"
                                  end
    end

    private

      def complete_filename(filename)
        "#{ @base_path }/#{ filename }#{ @hosts_file_suffix }"
      end

      def prefix(complete_filename)
        "# #{ complete_filename }\n\n"
      end

      def resolve_includes(hosts)
        hosts.sub(/\{(.+)\}/) { |include_filename| parse(include_filename[1..-2].strip) }
      end
  end

end
