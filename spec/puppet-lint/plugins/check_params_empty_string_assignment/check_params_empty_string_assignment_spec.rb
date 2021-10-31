require 'spec_helper'

describe 'params_empty_string_assignment' do
  let (:msg) { 'class parameter with String type defaults to empty string' }

  context 'with fix disabled' do
    context 'class definition without empty strings' do
      let (:code) {
        <<-EOS
        class foo ( $bar = 'baz' ) { }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'class internal variable without empty strings' do
      let (:code) {
        <<-EOS
        class foo ( ) { $bar = 'baz' }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'class definition with empty strings' do
      let (:code) {
        <<-EOS
        class foo ( String $bar = '' ) { }
        EOS
      }

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(1).in_column(28)
      end
    end
    context 'class internal variable with empty strings' do
      let (:code) {
        <<-EOS
        class foo ( ) { $bar = '' }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
  end
end
