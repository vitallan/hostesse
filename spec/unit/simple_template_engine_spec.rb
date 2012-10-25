require 'spec_helper.rb'

describe Hostesse::SimpleTemplateEngine do

  subject { Hostesse::SimpleTemplateEngine.new(base_path) }

  let(:base_path)                      { 'spec/support' }

  let(:simple_hosts_filename)          { 'simple' }
  let(:simple_hosts_complete_filename) { complete_filename(simple_hosts_filename) }

  describe 'simple hosts' do

    it "shouldn't change a simple file" do

      subject.parse(simple_hosts_filename).should match '127.0.0.1 localhost'

    end

    it 'should prepend the filename as a comment' do

      subject.parse(simple_hosts_filename).should match "# #{ simple_hosts_complete_filename }"

    end

    it 'should memoize the result' do

      first_result = subject.parse(simple_hosts_filename)

      File.stub(:read).with(simple_hosts_complete_filename).and_raise("it shouldn't need to read file again")

      subject.parse(simple_hosts_filename).should == first_result

    end

  end

  describe 'includes' do

    let(:include_hosts_filename)          { 'include' }
    let(:include_hosts_complete_filename) { complete_filename(include_hosts_filename) }

  end

  private

    def complete_filename(filename)
      File.expand_path("#{ base_path }/#{ filename }.hosts")
    end
end
