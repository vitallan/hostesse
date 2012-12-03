require 'hostesse/environment'

module Hostesse
  VERSION = '0.1.3' + (Hostesse::Environment.is_jruby? ? '-java' : '')
end
