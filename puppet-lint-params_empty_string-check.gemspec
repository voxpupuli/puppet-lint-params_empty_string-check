Gem::Specification.new do |spec|
  spec.name = 'puppet-lint-params_empty_string-check'
  spec.version     = '1.1.0'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-params_empty_string-check'
  spec.license     = 'MIT'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.summary = 'A puppet-lint plugin to check for class parameters assigned to the empty string.'

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'puppet-lint', '>= 3', '< 5'
end
