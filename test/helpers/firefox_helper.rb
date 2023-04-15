require "selenium/webdriver"
Capybara.register_driver :headless_firefox do |app|
  firefox_binary_path = "C:\\Program Files\\Mozilla Firefox\\firefox.exe" # Specify the binary location here
  browser_options = Selenium::WebDriver::Firefox::Options.new(binary: firefox_binary_path)
  browser_options.args << '--headless'
  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: browser_options
  )
end