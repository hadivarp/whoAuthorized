require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # config.eager_load_paths << Rails.root.join('lib')


    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.


    if File.exist?(File.expand_path('application.yml', __dir__))
      config = YAML.safe_load(File.read(File.expand_path('application.yml', __dir__)))
      config.merge! config.fetch(Rails.env, {})
      config.each do |key, value|
        ENV[key] = value.to_s
      end
    end
  end
end
