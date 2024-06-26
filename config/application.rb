require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatLive
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    config.after_initialize do |_config|
      ActiveRecord::Base.connection
    rescue ActiveRecord::NoDatabaseError, ActiveRecord::ConnectionNotEstablished => e
      if e.is_a?(ActiveRecord::NoDatabaseError)
        puts "Database was not created. User statuses were not changed."
      elsif e.is_a?(ActiveRecord::ConnectionNotEstablished)
        puts "Connection to database could not be established."
      end
    else
      if User.table_exists?
        User.update_all(online_status: :offline)
      else
        puts "User table doesn't exist. Migrations are expected."
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
