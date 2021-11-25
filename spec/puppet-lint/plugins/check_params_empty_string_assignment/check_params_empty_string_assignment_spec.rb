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

    context 'class definition with empty strings and 0 as minimal string length' do
      let (:code) {
        <<-EOS
        class foo ( String[0] $bar = '' ) { }
        EOS
      }

      it 'should detect one problem' do
        expect(problems).to have(1).problem
      end
    end

    context 'class definition with empty strings and loose Variant datatype 1' do
      let (:code) {
        <<-EOS
        class foo ( Variant[String[0], Integer] $bar = '' ) { }
        EOS
      }

      it 'should detect one problem' do
        expect(problems).to have(1).problem
      end
    end

    context 'class definition with empty strings and loose Variant datatype 2' do
      let (:code) {
        <<-EOS
        class foo ( Variant[Any, Optional] $bar = '' ) { }
        EOS
      }

      it 'should detect one problem' do
        expect(problems).to have(1).problem
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
    context 'class definition with value and minimal string length at 0' do
      let (:code) {
        <<-EOS
        class foo ( String[0] $var = 'public' ) { }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
    context 'class definition with value and no minimal string length' do
      let (:code) {
        <<-EOS
        class foo ( String $var = 'public' ) { }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
    # this usecase was reported on slack
    context 'class definition with value and string interpolation and values' do
      let (:code) {
        <<-EOS
        class foo (
          String $install_path = 'bla',
          String $bin_path = "${install_path}/public",
          ) {
            # code
          }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
    # this usecase was reported on slack as well
    context 'class definition with value and string interpolation and not all values' do
      let (:code) {
        <<-EOS
        class foo (
          String $install_path,
          String $bin_path = "${install_path}/public",
          ) {
            # code
          }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
    # this usecase was reported on slack as well
    context 'class definition with value and string interpolation and not all values and types' do
      let (:code) {
        <<-EOS
        class foo (
          String $install_path,
          String[1] $bin_path = "${install_path}/public",
          ) {
            # code
          }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
    # this usecase was reported on slack as well
    context 'class definition with value and string interpolation and not all values and types' do
      let (:code) {
        <<-EOS
        define bar::foo (
          String $install_path,
          String[1] $bin_path = "${install_path}/public",
          ) {
            # code
          }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
    # this usecase was reported on slack as well
    context 'class definition with value and string interpolation and not all values and types' do
      let (:code) {
        <<-EOS
        define profiles::host_api::nexus::managed::gem_installation (
          String $gem_source,
          String $gem_name,
          String $version,
          String $user,
          String $group,
          String $install_path,
          String[1] $bin_path = "${install_path}/bin",
          Boolean $add_bin_stub = false,
        ) {
          # code
        }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end
  end
end
