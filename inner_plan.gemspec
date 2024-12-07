require_relative "lib/inner_plan/version"

Gem::Specification.new do |spec|
  spec.name        = "inner_plan"
  spec.version     = InnerPlan::VERSION
  spec.authors     = ["mbajur"]
  spec.email       = ["mbajur@gmail.com"]
  spec.homepage    = "https://github.com/mbajur/inner_plan"
  spec.summary     = "Summary of InnerPlan."
  spec.description = "Description of InnerPlan."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mbajur/inner_plan"
  spec.metadata["changelog_uri"] = "https://github.com/mbajur/inner_plan"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.5"
  spec.add_dependency "turbo-rails"
  spec.add_dependency "positioning"
  spec.add_dependency "importmap-rails"
  spec.add_dependency "phlex", ">= 1.11"
  spec.add_dependency "phlex-rails"
  spec.add_dependency "phlex-icons-tabler", '~> 1.6'
  spec.add_dependency "trailblazer-rails"
  spec.add_dependency "stringex"
  spec.add_dependency "pundit", ">= 2.4.0"
end
