require_relative 'lib/getsafe/file_fetcher/version'

Gem::Specification.new do |spec|
  spec.name          = "getsafe-file-fetcher"
  spec.version       = Getsafe::FileFetcher::VERSION
  spec.authors       = ["Fellipe Fingoli"]
  spec.email         = ["fellipe.fingoli@gmail.com"]

  spec.summary       = %q{A small library to fetch files.}
  #spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  #spec.metadata["homepage_uri"] = spec.homepage
  #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "activemodel", "6.0.3.2"
end
