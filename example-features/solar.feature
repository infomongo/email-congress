Feature: Testing 'Solar'

Scenario: Basic Error Checking
	Given I go to "/solar/"
	Then the "My Address" field should have the placeholder text "123 Main St."
	When I click "Get My Free Assessment"
	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Phone Number"
	And the page should contain "Please Enter A Valid Email Address"
	# legal text present
	And the page should contain "and authorize SolarPulse and/or its partners"

Scenario: Make sure two words are in name field
	Given I go to "/solar/"
	And I enter "test" in the "First and Last Name" field
	When I click "Get My Free Assessment"
	Then the page should contain "Please Enter Your First and Last Name"

	And I enter "test test" in the "First and Last Name" field
	When I click "Get My Free Assessment"
	Then the page should not contain "Please Enter Your First and Last Name"

Scenario: Can't Sumbit a Zip in the Lead Form
	Given I go to "/solar/"
	And I enter "06516" in the "My Address" field
	And I enter "test test" in the "First and Last Name" field
	And I enter "5555555555" in the "My Phone Number" field
	And I click "Get My Free Assessment"
	And the "My Address" field should have the value "06516"
	Then the page should contain "Could Not Find This Address"
	And the "My Phone Number" field should have the value "555-555-5555"
	And the "First and Last Name" field should have the value "test test"

Scenario: Hidden Fields Created
	Given I go to "/solar/?pump=dump&cat=bag"
	Then the page should have a hidden field named "pump" with the value "dump"
	Then the page should have a hidden field named "cat" with the value "bag"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

@submit @ci-skip
Scenario: Submit NY Address -> Thanks
	Given I go to "/solar/"
	When I enter "46 Ovation Ct, White Plains, NY" in the "My Address" field
	And I enter "test xxxUNKNOWNxxx" in the "First and Last Name" field
	And I enter "3035555555" in the "My Phone Number" field
	And I enter "foo@bar.com" in the "email" field
	And I click "Get My Free Assessment"
	Then the page should not contain "Get My Free Assessment"
	Then the page should contain "Please verify your phone number"

Scenario: Ensure Analytics Are Present
	Given I go to "/solar/"
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
	Given I go to "/thanks/?state=nj"
	Then the page should contain the script "//www.googleadservices.com/pagead/conversion.js"
	And the page should contain the javascript "var google_conversion_id = 926513747;"
	And the page should contain the javascript "var google_remarketing_only = false;"
