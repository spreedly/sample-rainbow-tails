require File.expand_path('../../env', __FILE__)
require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups)
end

module RainbowTailsSample
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib)

    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.serve_static_assets = true
  end
end
