require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Police
  class Application < Rails::Application
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.active_record.raise_in_transactional_callbacks = true
    config.time_zone = 'Kyiv'
    config.autoload_paths << Rails.root.join('lib')
    config.generators do |g|
      g.test_framework :rspec, fixtures: true, views: false
    end
  end
end
