#encoding: UTF-8
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

    describe 'multiple includes' do

      let(:filename) { 'multiple_includes' }

      it 'should include all' do
        parsed_file.should match 'localhost'
        parsed_file.should match 'sample'
      end


    end

    describe 'cycles' do

      describe 'file include itself' do

        let(:filename) { 'include_itself' }

        it 'should avoid an infinite loop' do
          parsed_file.should match '# ERROR'
        end
      end

      describe 'two files include each other' do

        let(:filename) { 'simple_cycle_1' }

        it 'should avoid an infinite loop' do
          parsed_file.should match '# ERROR'
        end
      end
    end

    describe 'commented include' do

      let(:filename) { 'commented_include' }

      it "should keep the comment and don't render the include" do
        parsed_file.should match '# { commented_include }'
      end

    end
  end

  describe 'accents' do

    let(:filename) { 'accent' }

    it 'should handle accents properly' do

      parsed_file.should match '# çã'

    end

    describe 'include accents' do

      let(:filename) { 'include_accents' }

      it 'should handle accents in includes properly' do

        parsed_file.should match '# çã'

      end
    end
  end
end
