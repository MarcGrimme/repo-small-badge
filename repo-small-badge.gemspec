# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'repo_small_badge/version'

Gem::Specification.new do |s|
  s.name        = 'repo-small-badge'
  s.version     = RepoSmallBadge::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Marc Grimme']
  s.email       = ['marc.grimme at gmail dot com']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/marcgrimme/repo-small-badge'
  s.summary     = %(Small Badge generator to be used for different tools 4 ruby)
  s.description = %(Small Badge generator to be used for different tools 4 ruby)

  s.rubyforge_project = 'repo-small-badge'

  s.add_dependency 'mini_magick'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-small-badge'
  # s.add_development_dependency 'simplecov-small-badge'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`
                    .split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
