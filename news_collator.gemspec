lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "news_collator/version"

Gem::Specification.new do |spec|
  spec.name          = "news_collator"
  spec.version       = NewsCollator::VERSION
  spec.authors       = ["'Rohan Phillips'"]
  spec.email         = ["'rohan@solutions-insurance.com'"]

  spec.summary       = %q{"NewsCollator will visit a specified website and return a list of news articles"}
  spec.description   = %q{"This gem will take programmed specifications, pass them to a scraper and return a list of articles"}
  spec.homepage      = "https://github.com/rohanphillips/news_collator_cli_gem.git"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "http://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
