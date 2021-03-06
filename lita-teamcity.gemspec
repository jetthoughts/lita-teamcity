Gem::Specification.new do |spec|
  spec.name          = "lita-teamcity"
  spec.version       = "0.1.1"
  spec.authors       = ["Michael Nikitochkin"]
  spec.email         = ["miry.sof@gmail.com"]
  spec.description   = "Communicate with TeamCity REST API"
  spec.summary       = "Communicate with TeamCity REST API"
  spec.homepage      = "https://github.com/jetthoughts/lita-teamcity"
  spec.license       = "GPL-3.0"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"
  spec.add_runtime_dependency "teamcity", ">= 1.3.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
