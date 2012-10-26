require 'spec_helper.rb'

describe Hostesse::SimpleTemplateEngine do

  subject(:parsed_file)   { engine.parse(filename) }

  let(:engine)            { Hostesse::SimpleTemplateEngine.new(base_path) }

  let(:base_path)         { 'spec/support' }

  let(:filename)          { 'simple' }
  let(:complete_filename) { File.expand_path("#{ base_path }/#{ filename }.hosts") }

  describe 'simple hosts' do

    it "shouldn't change a simple file" do

      parsed_file.should match '127.0.0.1 localhost'

    end

    it 'should prepend the filename as a comment' do

      parsed_file.should match "# #{ complete_filename }"

    end
  end

  describe 'inexistent file' do

    let(:filename) { 'inexistent' }

    it 'should return an error' do

      parsed_file.should match '# ERROR'

    end

  end

  describe 'includes' do

    let(:filename) { 'include' }

    it 'should include a file' do
      parsed_file.should match '127.0.0.1 localhost'
    end

    describe 'cycles' do

      describe 'file include itself' do

        let(:filename) { 'include_itself' }

        it 'should avoid an infinite loop' do
          parsed_file.should match '# ERROR'
        end
      end
    end
  end
end
