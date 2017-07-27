require 'capybara/cucumber'
require 'capybara/poltergeist'

Capybara.app = 'base-app'
Capybara.app_host = ''
Capybara.default_driver = :poltergeist
Capybara.default_wait_time = 5
Capybara.register_driver :poltergeist do |app|
  cookiesFile = './cookies.txt'
  driver = Capybara::Poltergeist::Driver.new(app,
    {
      :js => true,
      :js_errors => true,
      :debug => false,
      phantomjs_options:["--proxy-type=none", "--ignore-ssl-errors=yes"],
      timeout:180
    }
  )
end

Capybara.register_driver :poltergeist_no_err do |app|
  cookiesFile = './cookies.txt'
  driver = Capybara::Poltergeist::Driver.new(app,
    {
      :js => true,
      :js_errors => false,
      :debug => false,
      phantomjs_options:["--proxy-type=none", "--ignore-ssl-errors=yes"],
      timeout:180
    }
  )
end

def switch_driver(driver)
  Capybara.current_driver = driver
end

Before('@mobile') do
  switch_driver :poltergeist
  # page.driver.headers = { "User-Agent" => "(iPhone Poltergeist Sim" }
  page.driver.resize(320, 960)
end

Before('@no-js-errors') do
  switch_driver :poltergeist_no_err
end

Before do |scenario|
  @scenario_name = scenario.name
end

Before do |scenario|
  # page.driver.headers = { "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.125 Safari/537.36" }
end

After do |scenario|
  screen_shot_and_save_page(scenario.title) if scenario.failed?
  # visit("/")
  # page.execute_script("window.localStorage.clear()")
end

AfterStep('@animation') do
  # This will only run after steps within scenarios tagged animation
  page.has_no_css?('.page-enter')
end

AfterStep('@pause') do |scenario|
  sleep 0.1
  puts '.'
end

AfterStep('@hidden-fields') do |scenario|
  #sleep 0.233
  # puts '.'
  
  #page.execute_script("console.log('foo')")
  #page.execute_script("var bill = window.localStorage.getItem('bill'); console.log(bill)")
end

AfterStep do |scenario|
  #sleep 0.1
  #puts '.'
end

def screen_shot_and_save_page(scenarioTitle)
  shot_name = "#{Time.now.strftime('%I-%M-%S-%L-')}" + scenarioTitle.gsub(' ', '-') + '.png'
  path = "screenshots/" + shot_name
  save_screenshot(path, :full => true)

  require "base64"
  #encode the image into it's base64 representation
  encoded_img = Base64.encode64(IO.read(path))
  #this will embed the image in the HTML report, embed() is defined in cucumber
  embed("data:image/png;base64,#{encoded_img}", 'image/png', "Screenshot")
end
