require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QiitaList
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # タイムゾーン
    config.time_zone = 'Tokyo'

    # デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja

    # /libファイル以下を自動でロード
    config.autoload_paths += Dir["#{config.root}/lib"]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
