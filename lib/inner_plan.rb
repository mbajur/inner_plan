require "inner_plan/version"
require "inner_plan/engine"
require "inner_plan/configuration"

require "turbo-rails"
require "positioning"
require "importmap-rails"
require "image_processing"
require "hotwire_combobox"

module InnerPlan
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
