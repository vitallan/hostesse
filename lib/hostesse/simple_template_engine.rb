module Hostesse

  class SimpleTemplateEngine

    def initialize(base_path, hosts_file_suffix = '.hosts')
      @base_path         = File.expand_path base_path
      @hosts_file_suffix = hosts_file_suffix
    end

    def parse(filename)
      complete_filename = complete_filename(filename)
      '# ' + complete_filename + "\n" +
      File.read(complete_filename)
    end

    def complete_filename(filename)
      "#{ @base_path }/#{ filename }#{ @hosts_file_suffix }"
    end
  end

end
