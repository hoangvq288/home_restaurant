require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HomeRestaurant
  class Application < Rails::Application
    config.generators do |generate|
      generate.helper false
      generate.javascripts false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
      generate.jbuilder false
    end
    config.autoload_paths += Dir[Rails.root.join('app/services')]
    config.load_defaults 5.2
    config.time_zone = 'Hanoi'
  end
end
