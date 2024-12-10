RSpec.configure do |config|
  # TODO Remove when Devise fixes https://github.com/heartcombo/devise/issues/5705
  config.before(:each, type: :system) do
    Rails.application.reload_routes_unless_loaded if Rails.application.respond_to?(:reload_routes_unless_loaded)
  end
end
