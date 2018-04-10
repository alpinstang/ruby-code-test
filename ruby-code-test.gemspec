
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby_code_test/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby-code-test"
  spec.version       = RubyCodeTest::VERSION
  spec.authors       = ["John McDonald"]
  spec.email         = ["john.mcdonald@hatboysoftware.com"]

  spec.summary       = %q{Coding test}
  spec.description   = %q{Sorts job execution order, placing dependencies first}
  spec.homepage      = "https://github.com/alpinstang/ruby-code-test"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "fuubar", "~> 2.3.1"
end
