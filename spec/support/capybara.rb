require "capybara/cuprite"

Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
end

RSpec.configure do |config|
  config.before(:each, type: :system, js: true) do
    include Devise::Test::IntegrationHelpers
    driven_by Capybara.javascript_driver
  end
end
