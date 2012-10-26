require 'spec_helper.rb'

describe Hostesse::SimpleTemplateEngine do

  subject { Hostesse::SimpleTemplateEngine.new(base_path) }

  let(:base_path)         { 'spec/support' }

  let(:filename)          { 'simple' }
  let(:complete_filename) { File.expand_path("#{ base_path }/#{ filename }.hosts") }

  describe 'simple hosts' do

    it "shouldn't change a simple file" do

      subject.parse(filename).should match '127.0.0.1 localhost'

    end

    it 'should prepend the filename as a comment' do

      subject.parse(filename).should match "# #{ complete_filename }"

    end
  end

  describe 'inexistent file' do

    let(:filename) { 'inexistent' }

    it 'should return an error' do

      subject.parse(filename).should match '# ERROR'

    end

  end

  describe 'includes' do

    let(:filename) { 'include' }

    it 'should include a file' do
      subject.parse(filename).should match '127.0.0.1 localhost'
    end

  end
end
