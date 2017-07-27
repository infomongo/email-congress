Feature: Testing 'Incentives'

Scenario: Link Works, Basic Error Checking & Legal Text
	Given I go to "/incentives/"
	Then the page should contain "Solar credits and rebates may be available to you"
	Then the page should contain "each state has its own set of available rebates and credits"
	When I click "Massachusetts"

	Then the page should contain "Start My Free Expert Review"
	Then the page should contain "and authorize SolarPulse and/or its partners"
	Then the page should have a hidden field named "path" with the value "/incentives/massachusetts/"
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Phone Number"
	And the page should contain "Please Enter A Valid Email Address"

Scenario: Make sure two words are in name field
	Given I go to "/incentives/new-york/"
	And I enter "test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your First and Last Name"

	And I enter "test test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should not contain "Please Enter Your First and Last Name"

Scenario: Basic Error Checking
	Given I go to "/incentives/new-york/"
	And I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Phone Number"
	Then the page should contain "Please Enter A Valid Email Address"

Scenario: Can't Sumbit a Zip in the Lead Form
	Given I go to "/incentives/new-york/"
	#Then the "My Address" field should not be disabled
	And I enter "06516" in the "My Address" field
	And I enter "Test xxxUNKNOWNxxx" in the "First and Last Name" field
	And I enter "5555555555" in the "My Phone Number" field
	And I enter "no@way.co" in the "My Email" field
	And I click "Start My Free Expert Review"
	And the "My Address" field should have the value "06516"
	Then the page should contain "Could Not Find This Address"
	And the "My Phone Numbe" field should have the value "555-555-5555"
	And the "First and Last Name" field should have the value "Test xxxUNKNOWNxxx"
	And the "My Email" field should have the value "no@way.co"

Scenario: Hidden Fields Created
	Given I go to "/incentives/maryland/?dropping=bodies"
	Then the page should contain "Start My Free Expert Review"
	Then the page should have a hidden field named "dropping" with the value "bodies"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for CT
	Given I go to "/incentives/connecticut/"
	Then the page should contain "Showing info for: Connecticut"
	And the page should contain "$6,435 Federal Income Tax Credit"
	And the page should contain "$2,970 Local Rebate"
	And the page should contain "$1,352 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for MD
	Given I go to "/incentives/maryland/"
	Then the page should contain "Showing info for: Maryland"
	And the page should contain "$8,775 Federal Income Tax Credit"
	And the page should contain "$1,000 Local Rebate"
	And the page should contain "$1,351 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for MA
	Given I go to "/incentives/massachusetts/"
	Then the page should contain "Showing info for: Massachusetts"
	And the page should contain "$5,940 Federal Income Tax Credit"
	And the page should contain "$1,000 State Income Tax Credit "
	And the page should contain "$1,000 SREC Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for NJ
	Given I go to "/incentives/new-jersey/"
	Then the page should contain "Showing info for: New Jersey"
	And the page should contain "$5,850 Federal Income Tax Credit"
	And the page should contain "$1,027 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for NY
	Given I go to "/incentives/new-york/"
	Then the page should contain "Showing info for: New York"
	And the page should contain "$6,480 Federal Income Tax Credit"
	And the page should contain "$5,000 State Tax Credit "
	And the page should contain "$1,157 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for CA
	Given I go to "/incentives/california/"
	Then the page should contain "Showing info for: California"
	And the page should contain "$4,830 Federal Income Tax Credit"
	And the page should contain "$826-$925 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for CO
	Given I go to "/incentives/colorado/"
	Then the page should contain "Showing info for: Colorado"
	And the page should contain "$4,440 Federal Income Tax Credit"
	And the page should contain "$1,375 Performance Based Incentives"
	And the page should contain "$667 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

Scenario: Check Incentives for RI
	Given I go to "/incentives/rhode-island/"
	Then the page should contain "Showing info for: Rhode Island"
	And the page should contain "$5,040 Federal Income Tax Credit"
	And the page should contain "$1,782 Performance Based Incentives"
	And the page should contain "$909 Net Metering Credits per Year"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

@submit @ci-skip
Scenario: Submit NY Address -> Thanks
	Given I go to "/incentives/new-york/"
	And I enter "46 Ovation Ct, White Plains, NY" in the "My Address" field
	And I enter "test xxxUNKNOWNxxx" in the "First and Last Name" field
	And I enter "3035555555" in the "phone" field
	And I enter "foo@bar.com" in the "email" field
	And I click "Start My Free Expert Review"
	#And I pause for "5" seconds
	Then the page should not contain "Start My Free Expert Review"
	Then the page should contain "Please verify your phone number"

Scenario: Ensure Analytics Are Present
	Given I go to "/incentives/"
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
	Given I go to "/incentives/thanks/?state=nj"
	Then the page should contain the script "//www.googleadservices.com/pagead/conversion.js"
	And the page should contain the javascript "var google_conversion_id = 926513747;"
	And the page should contain the javascript "var google_remarketing_only = false;"
