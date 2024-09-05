require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  :chrome :headless_chrome 
  # :firefox :headless_firefox
     
  config = SystemTestConfig.new :headless_firefox

  driven_by :selenium, using: config.driver, 
    screen_size: [1400, 1400],
    options: config.driver_options do |driver_option|
        driver_option.add_argument('--disable-search-engine-choice-screen')
    end
