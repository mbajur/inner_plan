source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in inner_plan.gemspec.
gemspec

gem "puma"

gem "sprockets-rails"

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

eval_gemfile File.expand_path("spec/gemfiles/rails_8.0.gemfile", __dir__)
