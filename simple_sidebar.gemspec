require_relative 'lib/simple_sidebar/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_sidebar"
  spec.version       = SimpleSidebar::VERSION
  spec.authors       = ["Mai Abuthraa"]
  spec.email         = ["mai@abuthraa.com"]

  spec.summary       = "Sidebar made easy!"
  spec.description   = "Sidebar made easy!"
  spec.homepage      = "https://github.com/MaiAbuthraa/simple_sidebar"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
