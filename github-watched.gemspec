# -*- encoding: utf-8 -*-
require File.expand_path('../lib/github_watched/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Weathered"]
  gem.email         = ["jason@jasoncodes.com"]
  gem.summary       = %q{List all watched GitHub repositories}
  gem.homepage      = "https://github.com/jasoncodes/github-watched"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "github-watched"
  gem.require_paths = ["lib"]
  gem.version       = GitHubWatched::VERSION

  gem.add_dependency 'octocat_herder', '>= 0.1.2'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'gem-release'
end
