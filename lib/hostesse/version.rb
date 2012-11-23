require 'hostesse/environment'

module Hostesse
  VERSION = '0.1.0' + (Hostesse::Environment.is_jruby? ? '-java' : '')
end
