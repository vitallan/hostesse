# encoding: UTF-8
module Hostesse
  class Cli
    class Messages

      def initialize(cli)
        @cli = cli
      end

      def welcome
        <<-MESSAGE.gsub(/^ +/, '')
          Welcome to hostesse (#{ Hostesse::VERSION })!

          The current target file is #{ @cli.target_file }. Note that you need permission to write in this file!

          The current base directory is #{ @cli.base_dir }.

          To change hosts, type the name of the file, without the .hosts suffix.
          Tab completion should help you in this.

          To refresh the hosts, hit enter.

        MESSAGE
      end

      def ps1
        'hostesse' +
        (@cli.current_hosts_definition ? " [#{ @cli.current_hosts_definition }]" : '') +
        (@cli.errors_in_target_file? ? '✗' : '') +
        '> '
      end

      def change_hosts
        if @cli.errors_in_target_file?
          "There is a error in your hosts definition. See #{ @cli.target_file } for more details"
        else
          "Hosts changed to #{ @cli.current_hosts_definition }"
        end
      end

      def error_target_file_isnt_writable
        <<-MESSAGE.gsub(/^ +/, '')
          #{ @cli.target_file } isn't writable, hosts not saved!

          Solve this by running hostesse as root or changing
          the permissions for #{ @cli.target_file }
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

      class << self
        def exit
          <<-MESSAGE.gsub(/^ +/, '')

            Thanks for using hostesse!

            :)

          MESSAGE
        end
      end
    end
  end
end
