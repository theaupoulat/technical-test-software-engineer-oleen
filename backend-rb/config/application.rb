require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.eager_load_paths << "#{Rails.root}/app"
    config.autoload_paths += %W(#{config.root}/proto)
    config.autoload_paths += %W(#{config.root}/lib)
    config.api_only = true
    config.time_zone = "Paris"
    config.i18n.default_locale = :fr
    config.i18n.locale = :fr
    config.active_record.schema_format = :sql
  end
end
