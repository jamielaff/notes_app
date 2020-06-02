require 'capybara/rails'
require "capybara/rspec"
# require "capybara-screenshot"
require "selenium-webdriver"

SELENIUM_HOST = ENV['SELENIUM_HOST'] || 'notes'
SELENIUM_PORT = ENV['SELENIUM_PORT'] || '80'

# Capybara::Screenshot.prune_strategy = :keep_last_run

Capybara.register_driver :selenium_remote do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: ['silent'] }
    )

  client = Selenium::WebDriver::Remote::Http::Default.new

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    url: "http://#{SELENIUM_HOST}:#{SELENIUM_PORT}",
    http_client: client,
    desired_capabilities: capabilities
  )
end

Capybara.configure do |config|
  config.run_server = true
  config.default_driver = :rack_test
  config.always_include_port = true
  config.raise_server_errors = true
  config.javascript_driver = :selenium_remote
end