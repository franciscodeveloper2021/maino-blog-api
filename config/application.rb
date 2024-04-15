require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MainoBlogApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Allowing fallback to happen
    config.i18n.fallbacks = true

    # Set available locales
    config.i18n.available_locales = [:pt, :en]

    # Set the default time zone
    config.time_zone = 'Brasilia'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Configure autoload paths
    config.autoload_paths << Rails.root.join("lib").to_s
    config.autoload_paths += Dir[Rails.root.join('lib', '**/')]
    config.autoload_paths -= %W(#{config.root}/lib/assets #{config.root}/lib/tasks)
  end
end
