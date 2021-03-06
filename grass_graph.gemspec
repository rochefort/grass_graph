# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "grass_graph/version"

Gem::Specification.new do |spec|
  spec.name          = "grass_graph"
  spec.version       = GrassGraph::VERSION
  spec.authors       = ["rochefort"]
  spec.email         = ["terasawan@gmail.com"]

  spec.summary       = "Save a PNG image of the specified GitHub grass-graph and upload it to s3 and dropbox"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/rochefort/grass_graph"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "aws-sdk", "~> 3"
  spec.add_dependency "dropbox_api", "~> 0.1.13"
  spec.add_dependency "mini_magick", "~> 4.9.2"
  spec.add_dependency "nokogiri", "~> 1.8.5"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 12.3.1"
  spec.add_development_dependency "rspec", "~> 3.8"
end
