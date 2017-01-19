require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AnimalGuess
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # recommended method for custom config based on
    # http://guides.rubyonrails.org/configuring.html#custom-configuration
    config.external_services = config_for(:external_services)
  end
end
