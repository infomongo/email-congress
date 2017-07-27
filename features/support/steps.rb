
Given(/^I go to "(.*?)"$/) do |path|
  visit(path)
end

When(/^I click "([^\"]*?)"$/) do |text|
  puts click_on(text)
end

When(/^I click the back button$/) do
  page.driver.go_back
end

Then(/^I click the first "([^"]*)" button$/) do |text|
  page.first('button', :text => text).click
end

Then(/^I click the button "([^"]*)" at the "([^"]*)" of the page$/) do |text, locator|
  page.find('.'+locator).first('button', :text => text).click
end

Given(/^I click the link "([^"]*)" that I'm careful to locate$/) do |text|
  page.first('a', :text => text).click
end

Then(/^I click the Continue button$/) do
  page.first('.button').click
end

When(/^I take a screenshot$/) do
  #puts @scenario_name
  #screen_shot_and_save_page('manual')

  puts path = "screenshots/" + @scenario_name.gsub(' ', '-') + '.png'
  save_screenshot(path, :full => true)

  # pending # Write code here that turns the phrase above into concrete actions
end

def getIconClassesByText( filterText )
  page.find('.filters-column')
    .find('a', :text => filterText)
    .find('i')[:class]
end

When(/^I remove the (\d+)\w\w provider$/) do |index|
  page.all('.listing')[index.to_i].find('a', :text => 'Remove').click
end

Then(/^the "([^"]*)" filter should be checked$/) do |filterText|
  iconClassList = getIconClassesByText(filterText)

  expect(iconClassList).to have_content('fa-check-square-o')
  expect(iconClassList).not_to have_content('fa-square-o')
end

Then(/^the "([^"]*)" filter should not be checked$/) do |filterText|
  iconClassList = getIconClassesByText(filterText)

  expect(iconClassList).not_to have_content('fa-check-square-o')
  expect(iconClassList).to have_content('fa-square-o')
end

When(/^I click "([^"]*)" in the "([^"]*)" filter$/) do |linkText, filterText|
  # this is a hack, clicking was happening before listener attached
  find('.filter-wrap', :text => filterText).find('a', :text => linkText).click
end

Given(/^I click the link "([^"]*)" in a listing$/) do |link|
  find('.listings').first('a', :text => link).click
end

When(/^I check "([^"]*)"$/) do |filterText|
  page.find('.filters-column').find('a', :text => filterText).click
end

Given(/^that I filter by "([^"]*)"$/) do |filterText|
  page.find('.filters-column').find('a', :text => filterText).trigger('click')
  #had to change to .trigger('click') to work around a bug in poltergeist
end

When(/^I uncheck "([^"]*)"$/) do |filterText|
  page.find('.filters-column').find('a', :text => filterText).click
end

def getFilterByElement( filterByText )
  page.find('.active-filter')
    .find('a', :text => filterByText)
end

Then(/^the "([^"]*)" filter by should be visible$/) do |filterByText|
  getFilterByElement( filterByText )
end

Then(/^the "([^"]*)" filter by should not be visible$/) do |filterByText|
  if page.has_css?('.active-filter')
    expect( getFilterByElement( filterByText ) ).to raise_error
  end
end

When(/^I click "([^"]*)" filter by$/) do |filterByText|
  getFilterByElement( filterByText ).click
end

Given(/^I am logged in as "([^"]*)" with "([^"]*)"$/) do |username, password|
  step 'I clear localstorage'
  step 'I go to "/#/login"'
	step 'I input "'+username+'" in the "email" input'
	step 'I input "'+password+'" in the "password" input'
  step 'I click "Log In"'
  step 'the page should contain "Find a Provider"'
end

Given(/^I am logged in as a valid user$/) do
  step 'I clear localstorage'
  step 'I go to "/#/login"'
  step 'I input "test@test.com" in the "email" input'
  step 'I input "password11" in the "password" input'
  step 'I click "Log In"'
  step 'the page should contain "Find a Provider"'
end

Given(/^I clear localstorage$/) do
  visit("/#/")
  page.execute_script("window.localStorage.clear()")
end


Then(/^the page should contain (\d+) search results$/) do |numOfResults|
  expect(page.all('.listings .listing').length).to equal(numOfResults.to_i)
end

Then(/^the page should contain "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^the page should not contain "([^"]*)"$/) do |text|
  expect(page).not_to have_content(text)
end

Then(/^the path should contain "([^"]*)"$/) do |text|
  expect(current_url).to include(text)
end

Then(/^the path should not contain "([^"]*)"$/) do |text|
  expect(current_url).not_to include(text)
end

Then(/^the field "([^"]*)" should contain "([^"]*)"$/) do |label, text|
  expect(find_field(label).value).to include(text)
end

Then(/^the field "([^"]*)" should not contain "([^"]*)"$/) do |label, text|
  expect(find_field(label).value).not_to include(text)
end

Then(/^the "([^"]*)" field should have the placeholder text "([^"]*)"$/) do |field, text|
  expect(find_field(field)[:placeholder]).to include(text)
end

Then(/^the field "([^"]*)" should be empty$/) do |field|
  expect(page.has_field?(field, :with => '')).to eq(true)
end

Then(/^the "([^"]*)" field should have the value "([^"]*)"$/) do |field, value|
  #puts page.find_field(field).value
  expect(page.has_field?(field, :with => value)).to eq(true)
end

currentWorkingFormEl = nil
When(/^I focus on the "([^"]*)" form$/) do |formName|
  currentWorkingFormEl = page.find("form[name=\"#{formName}\"]")
end

When(/^I input "([^"]*)" in the "([^"]*)" input$/) do |text, textInputName|
  currentWorkingFormEl = currentWorkingFormEl || page
  currentWorkingFormEl.fill_in textInputName, :with => text
end

Then(/^I input "([^"]*)" in the "([^"]*)" field$/) do |text, field|
  page.fill_in field, :with => text
end

When(/^I enter "([^"]*)" in the "([^"]*)" field$/) do |text, field|
  page.fill_in field, :with => text
end

When(/^I select "([^"]*)" from the "([^"]*)" input$/) do |value, input|
  page.select value, :from => input
end

Then(/^I select "([^"]*)" from the "([^"]*)" menu$/) do |value, menu|
  page.select value, :from => menu
end

Then(/^I find the text area "([^"]*)" and set it to$/) do |textarea, text|
  page.fill_in textarea, :with => text
end

Then(/^the menu "([^"]*)" should have "([^"]*)" selected$/) do |label, value|
  expect(page.has_select?(label, :selected => value)).to eq(true)
end

Then(/^the Electric Bill bill menu should have a value of "([^"]*)"$/) do |value|
  #puts find('.bill-menu').value
  expect(find('.bill-menu').value).to eq(value)
end

When(/^the input "([^"]*)" should equal "([^"]*)"$/) do |input, value|
  expect(find_field(input).value).to eq(value)
end

When(/^I input a random "([^"]*)" in the "([^"]*)" input$/) do |randomType, textInputName|
  randomDataPoint = 'test' + rand.to_s + '@test.com'
  # randomDataPoint will be something like test0.8388961581348353@test.com
  page.fill_in textInputName, :with => randomDataPoint
end

Given(/^I click the check box "([^"]*)"$/) do |label|
  page.check(label)
  #page.check('emailPermission')
end

When(/^I click the home icon$/) do
  find('a[title=home]').click
end

When(/^I click "([^"]*)" for listing "([^"]*)"$/) do |linkText, physicianName|
  find('.listing', :text => physicianName)
    .find('a', :text => linkText)
    .click
end

Then(/^the page should have an error that reads "([^"]*)"$/) do |text|
  page.find('.error', :text => text)
end

Given(/^I click "([^"]*)" on the first result$/) do |target|
  page.first('.listing').click_on(target)
end

Given(/^I click the provider name on the first result$/) do
  page.first('.listing').first('.title').click
end


Then(/^the provider name of the first listing should be a link$/) do
  firstListing = page.first('.listing')
  titleText = firstListing.first('.title').text
  expect(firstListing.has_link?(titleText)).to eq(true)
end

Then(/^the provider name of the first listing should not be a link$/) do
  firstListing = page.first('.listing')
  titleText = firstListing.first('.title').text
  expect(firstListing.has_link?(titleText)).to eq(false)
end


Then(/^the page should contain a phone number$/) do
  foundElment = page.first('.phone')
  target = foundElment.text
  expect(target.length).to be >  0
end

Then(/^the page should contain an address$/) do
  foundElment = page.first('.address')
  target = foundElment.text
  expect(target.length).to be >  0
end

Then(/^the page should have a list of IPAa$/) do
  foundElment = page.first('ul.ipa-list')
  target = foundElment.text
  expect(target.length).to be >  0
end

Given(/^the page should have an interactive map$/) do
  page.find('.angular-google-map-container div[title="Zoom in"]')
end

Then(/^the first result should contain "([^"]*)"$/) do |text|
  expect(page.first('.listing')).to have_content(text)
end

Then(/^the saved icon should show "([^"]*)" saved provider$/) do |count|
  expect(page.first('.save-wrap')).to have_content(count)
end

Then(/^I pause for "([^"]*)" seconds$/) do |time|
  sleep time.to_i
end

Then(/^the address input should have the placeholder text "([^"]*)"$/) do | placeholderText |
  expect(page.find('[name="autocomplete-address"]')[:placeholder]).to eq(placeholderText)
end

Then(/^the page should have a hidden field named "([^"]*)" with the value "([^"]*)"$/) do |field, value|
  #expect(page.find('[name="'+field+'"]', :visible => false).value).to eq(value)
  # the commented construction is less reliable than the nearly identical construction below
  # the commented on only works for hidden fields that are added via js, not those that exist and have a value changed by js
  expect(page.find('[name="'+field+'"][value*="'+value+'"]', :visible => false))
end

Then(/^the page should have a hidden field named "([^"]*)" that contains the value "([^"]*)"$/) do |field, value|
  expect(page.find('input[name="'+field+'"][value*="'+value+'"]', :visible => false))
end

Then(/^the "([^"]*)" input should have the placeholder text "([^"]*)"$/) do |inputName, placeholderText|
  expect(page.find('[name="'+inputName+'"]')[:placeholder]).to eq(placeholderText)
end

Then(/^the hidden field "([^"]*)" should equal "([^"]*)"$/) do |inputName, value|
  expect(page.first('[name="'+inputName+'"]', :visible => false).value).to eq(value)
end

When(/^I click on the "([^"]*)" field$/) do |field|
  page.find_field(field).click
end

Then(/^the address menu should be visible$/) do
  my_menu = page.find('div.pac-container')
end

Then(/^the "([^"]*)" field should not be disabled$/) do |field|
   page.find_field(field, disabled: false)
end

Then(/^the page should contain the script "([^"]*)"$/) do |scriptSrc|
  expect( page.all('script', visible: false).find{ | s | s[:src] == scriptSrc }).not_to be_nil
end

Then(/^the page should contain the javascript "([^"]*)"$/) do | jsExpression |
  scriptEl = page.all('body script', visible: false).find do |el|
    el.text(:all).include? jsExpression
  end
  expect(scriptEl).not_to be_nil
end

Then(/^the phone number should be a link$/) do
  #puts find(:xpath, "//a[contains(@href, 'tel')]").text
  find(:xpath, "//a[contains(@href, 'tel:')]")
end

Then(/^the "([^"]*)" share link is present$/) do |class_text|
  thatsthelink = "a." + class_text
  #puts find(thatsthelink)[:href]
  find(thatsthelink)
end
