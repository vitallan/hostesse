module Hostesse
  module Cli
    module Messages
      class << self
        def welcome(target_file, current_dir)
          <<-MESSAGE.gsub(/^ +/, '')
            Welcome to hostesse (#{ Hostesse::VERSION })!

            The current target file is #{ target_file }. Note that you need permission to write in this file!

            To change hosts, type the name of the file, without the .hosts suffix.
            Tab completion should help you in this.

            To refresh the hosts, hit enter.

          MESSAGE
        end

        def exit
          <<-MESSAGE.gsub(/^ +/, '')

            Thanks for using hostesse!

            :)

          MESSAGE
        end

        def error_in_definition_file(target_file)
          "There is a error in your hosts definition. See #{ target_file } for more details"
        end

        def error_target_file_isnt_writable(target_file)
          <<-MESSAGE.gsub(/^ +/, '')
            #{ target_file } isn't writable, hosts not saved!

            Solve this by running hostesse as root or changing
            the permissions for #{ target_file }
          MESSAGE
        end

        def error_very_bad_error(error)
          <<-MESSAGE.gsub(/^ +/, '')
            Something went terribly wrong!

            Please report this error with the following message:

            #{ error }
            #{ error.backtrace }
          MESSAGE
        end
      end
    end
  end
end
