module Hostesse

  class SimpleTemplateEngine

    def initialize(base_path, hosts_file_suffix = '.hosts')
      @base_path         = File.expand_path base_path
      @hosts_file_suffix = hosts_file_suffix
      @parsed            = {}
    end

    def parse(filename)
      complete_filename = complete_filename(filename)
      if already_parsed? complete_filename
        @parsed[complete_filename]
      else
        @parsed[complete_filename] = prefix(complete_filename) + File.read(complete_filename)
      end
    end

    private

      def complete_filename(filename)
        "#{ @base_path }/#{ filename }#{ @hosts_file_suffix }"
      end

      def prefix(complete_filename)
        "# #{ complete_filename }\n\n"
      end

      def already_parsed?(complete_filename)
        !! @parsed[complete_filename]
      end
  end

end
