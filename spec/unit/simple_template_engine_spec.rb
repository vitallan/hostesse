require 'spec_helper.rb'

describe Hostesse::SimpleTemplateEngine do

  subject { Hostesse::SimpleTemplateEngine.new('spec/support/simple_hosts') }

  it "shouldn't change a simple file" do

    subject.parse('localhost').should match '127.0.0.1 localhost'

  end

  it 'should prepend the filename as a comment' do

    subject.parse('localhost').should match "# #{ File.expand_path('spec/support/simple_hosts/localhost.hosts') }"

  end

end
