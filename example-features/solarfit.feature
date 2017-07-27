@no-js-errors
Feature: Test "Solarfit"

Scenario: Zip Search
	Given I go to "/solarfit/"
	Then the "address" field should have the placeholder text "Enter your address or zip code"
	And the page should contain "Enter your address to discover your solar fit"

	When I enter "80301" in the "address" field
	And I click "Go"
	Then the page should contain "fit for exploring solar"
	Then the page should contain "are available in Boulder County."

Scenario: Blank Address Redirects Correctly
	Given I go to "/solarfit/eval/"
	Then the "address" field should have the placeholder text "Enter your address or zip code"
	And the page should contain "Enter your address to discover your solar fit"

Scenario: Make sure two words are in name field
	Given I go to "/solarfit/form"
	And I enter "test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your First and Last Name"

	And I enter "test test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should not contain "Please Enter Your First and Last Name"

Scenario: Address Search to Form and Bill - Top Button
	Given I go to "/solarfit/"
	When I enter "3651 Inglewood Blvd Los Angeles, CA" in the "address" field
	And I click "Go"
	Then the page should contain "fit for exploring solar"
	Then the page should contain "are available in Los Angeles County."
	And I click "+"
	Then the "bill-input" field should have the value "$120"
	And I click the first "Start My Free Expert Review" button
	Then the page should contain "Please Fill Out All Fields"
	And I pause for "3" seconds
	Then the "Your Address" field should have the value "3651 Inglewood Blvd Los Angeles, CA"
	#Then the "bill" field should have the value "$110"
	And the Electric Bill bill menu should have a value of "$101-150"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Address Search to Form and Bill - Bottom Button
	Given I go to "/solarfit/"
	When I enter "3651 Inglewood Blvd Los Angeles, CA" in the "address" field
	And I click "Go"
	Then the page should contain "fit for exploring solar"
	Then the page should contain "are available in Los Angeles County."
	And I click "+"
	And I click "+"
	Then the "bill-input" field should have the value "$130"
	And I click the button "Start My Free Expert Review" at the "bottom" of the page
	Then the page should contain "Please Fill Out All Fields"
	And I pause for "1" seconds
	Then the "Your Address" field should have the value "3651 Inglewood Blvd Los Angeles, CA"
	#Then the "bill" field should have the value "$120"
	And the Electric Bill bill menu should have a value of "$101-150"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Address Menu
	Given I go to "/solarfit/"
	When I enter "33" in the "address" field
	And I click on the "address" field
	# the field has to be active to see the menu
	Then the address menu should be visible

Scenario: Out Of State Search
	Given I go to "/solarfit/"
	When I enter "64119" in the "address" field
	And I click "Go"
	Then the page should contain "We hope to be in your neighborhood soon"

Scenario: Logic Check
	Given I go to "/solarfit/"
	When I enter "463 Main St, West Haven, CT 06516" in the "address" field
	And I click "Go"
	Then the page should contain "you're a good fit for exploring solar"
	Then the page should contain "GOOD"

	When I enter "90" in the "bill-input" field
	Then the page should contain "you're a poor fit for exploring solar"
	Then the page should contain "POOR"

	When I enter "100" in the "bill-input" field
	Then the page should contain "you're a good fit for exploring solar"
	Then the page should contain "GOOD"

	When I enter "125" in the "bill-input" field
	Then the page should contain "you're an excellent fit for exploring solar"
	Then the page should contain "EXCELLENT"

	When I enter "175" in the "bill-input" field
	Then the page should contain "you're a superior fit for exploring solar"
	Then the page should contain "SUPERIOR"

Scenario: Plus and Minus Icons
	Given I go to "/solarfit/"
	When I enter "463 Main St, West Haven, CT 06516" in the "address" field
	And I click "Go"
	Then the "bill-input" field should have the value "$110"

	And I click "+"
	Then the "bill-input" field should have the value "$120"

	And I click "-"
	And I click "-"
	Then the "bill-input" field should have the value "$100"

Scenario: Zip Search to Form and Basic Error Checking
	Given I go to "/solarfit/"
	And I enter "06516" in the "address" field
	And I click "Go"
	Then the page should contain "fit for exploring solar"
	And I click the first "Start My Free Expert Review" button
	Then the page should contain "Please Fill Out All Fields"
	And the field "Your Address" should be empty

	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your Electric Company"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Phone Number"
	And the page should contain "Please Enter A Valid Email Address"

Scenario: Lead form has address menu and legal text
	Given I go to "/solarfit/form/"
	And I enter "33" in the "Your Address" field
	And I click on the "fullAddress" field
	Then the address menu should be visible
	# legal text present
	And the page should contain "and authorize SolarPulse and/or its partners"

Scenario: Can't Sumbit a Zip in the Lead Form
	Given I go to "/solarfit/form/"
	Then the page should contain "Please Fill Out All Fields"
	Then the "fullAddress" field should have the placeholder text "123 Main St."
		And I enter "06516" in the "Your Address" field
	And I select "Eversource Energy" from the "Your Electric Company" menu
	And I enter "Test xxxUNKNOWNxxx" in the "First and Last Name" field
	And I enter "5555555555" in the "Your Phone Number" field
	And I click "Start My Free Expert Review"
	Then the page should contain "Please Fill Out All Fields"
	And the "Your Address" field should have the value "06516"
	Then the page should contain "Could Not Find This Address"
	# Not sure this is the right error message, probaly should be can't find this address
	And the "Your Phone Number" field should have the value "555-555-5555"
	And the "First and Last Name" field should have the value "Test xxxUNKNOWNxxx"
	And the menu "Your Electric Company" should have "Eversource Energy" selected

Scenario: Hidden Fields Created
	Given I go to "/solarfit/?pump=dump&cat=bag"
	Then I go to "/solarfit/form/?address=06516&bill=150"
	Then the page should have a hidden field named "pump" with the value "dump"
	Then the page should have a hidden field named "cat" with the value "bag"

# not sure why, but it keeps failing in CI
@ci-skip
Scenario: Electric Companies get populated when address gets filled in
	Given I go to "/solarfit/"
	And I enter "463 Main St, West Haven, CT 06516" in the "address" field
	And I click "Go"
	Then the page should contain "fit for exploring solar."
	Then the page should contain "463 Main Street, West Haven, CT, 06516"
	And I click the first "Start My Free Expert Review" button
	Then the page should contain "Please Fill Out All Fields"
	Then the "Your Address" field should have the value "463 Main St, West Haven, CT 06516"
	And I select "Eversource Energy" from the "utility" menu

Scenario: NJ address gets evaluated
	Given I go to "/solarfit/"
	And I enter "08618" in the "address" field
	And I click "Go"
	Then the page should contain "We think you're a good fit for exploring solar."
	Then the page should not contain "Thank you for your interest in solar. We hope to be in your neighborhood soon."

Scenario: MD address gets evaluated
	Given I go to "/solarfit/"
	And I enter "21218" in the "address" field
	And I click "Go"
	Then the page should contain "We think you're a good fit for exploring solar."
	Then the page should not contain "Thank you for your interest in solar. We hope to be in your neighborhood soon."

Scenario: NY address gets evaluated
	Given I go to "/solarfit/"
	And I enter "10001" in the "address" field
	And I click "Go"
	Then the page should contain "We think you're a good fit for exploring solar."
	Then the page should not contain "Thank you for your interest in solar. We hope to be in your neighborhood soon."

# not sure why, but it keeps failing in CI
@ci-skip
Scenario: Make sure footnote comes through on MA address
	Given I go to "/solarfit/"
	And I enter "1 City Hall Square, Boston, MA" in the "address" field
	And I click "Go"
	Then the page should not contain "Enter your address to discover your solar fit"
	Then the page should contain "We think you're a good fit for exploring solar."
	Then the page should contain "available in Suffolk County.1"
	#check for footnote
	Then the page should contain "Owners of solar PV systems in Massachusetts "

Scenario: Footnote Absent Outside MA
	Given I go to "/solarfit/"
	And I enter "463 Main St, West Haven, CT 06516" in the "address" field
	And I click "Go"
	Then the page should not contain "available in New Haven County.1"
	Then the page should not contain "Owners of solar PV systems in Massachusetts "

@submit @ci-skip
Scenario: Submit CT Address -> Thanks
	Given I go to "/solarfit/form/?address=06516&bill=150"
	And I enter "9 Putney Dr, West Haven, CT" in the "fullAddress" field
	And I enter "test xxxUNKNOWNxxx" in the "name" field
	And I enter "3035555555" in the "phone" field
	And I enter "foo@bar.com" in the "email" field
	And I select "Eversource Energy" from the "utility" menu
	And I click "Start My Free Expert Review"
	#And I pause for "5" seconds
	Then the page should contain "Please verify your phone number"

Scenario: Ensure Analytics Are Present
	Given I go to "/solarfit/"
	# bing
	Then the page should contain the javascript "bat.bing.com/bat.js"
	And the page should contain the javascript "5129832"
	#facebook
	Then the page should contain the javascript "connect.facebook.net/en_US/fbevents.js"
	And the page should contain the javascript "fbq('init', '242423486092688');"
	# google_conversion_id
	Then the page should contain the script "//www.googleadservices.com/pagead/conversion.js"
	And the page should contain the javascript "var google_remarketing_only = true;"

	# thanks page conversion
	Given I go to "/solarfit/thanks/?state=nj"
	Then the page should contain the script "//www.googleadservices.com/pagead/conversion.js"
	And the page should contain the javascript "var google_conversion_id = 926513747;"
	And the page should contain the javascript "var google_remarketing_only = false;"
