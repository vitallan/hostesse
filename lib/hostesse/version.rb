require 'hostesse/environment'

module Hostesse
  VERSION = '0.0.7' + (Hostesse::Environment.is_jruby? ? '-java' : '')
end
