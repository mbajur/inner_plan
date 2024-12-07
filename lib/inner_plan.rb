require "inner_plan/version"
require "inner_plan/engine"
require "inner_plan/configuration"
require "inner_plan/smart_array"

require "turbo-rails"
require "positioning"
require "importmap-rails"
require "phlex"
require "phlex-rails"
require "phlex-icons-tabler"
require "trailblazer-rails"
require "stringex"

module InnerPlan
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  mattr_accessor :importmap, default: Importmap::Map.new
end
