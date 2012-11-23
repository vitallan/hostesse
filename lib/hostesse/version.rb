require 'hostesse/environment'

module Hostesse
  VERSION = '0.1.1' + (Hostesse::Environment.is_jruby? ? '-java' : '')
end
