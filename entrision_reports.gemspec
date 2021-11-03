require_relative 'lib/entrision_reports/version'

Gem::Specification.new do |spec|
  spec.name          = 'entrision_reports'
  spec.version       = EntrisionReports::VERSION
  spec.authors       = ['Robert D. Cotey II']
  spec.email         = ['rcotey@entrision.com']

  spec.summary       = '{Basic Reports Engine for Entrision}'
  spec.description   = 'Basic generic reporting engine for Entrision apps'
  spec.homepage      = 'https://entrision.com/'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'chartkick'
  spec.add_runtime_dependency 'sidekiq'
  spec.add_runtime_dependency 'activeadmin'

end
