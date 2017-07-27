Feature: Testing 'Fit'

Scenario: Test Zip Input
	Given I go to "/fit"
	Then the "zip" input should have the placeholder text "Zip Code"
	When I click "GO"
	Then the page should contain "Please enter your zip code."

Scenario: Make sure two words are in name field
	Given I go to "/fit/form"
	And I enter "test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your First and Last Name"

	And I enter "test test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should not contain "Please Enter Your First and Last Name"

@hidden-fields
Scenario: Test the full positive flow
	Given I go to "/fit"
	Then the "zip" input should have the placeholder text "Zip Code"
	When I enter "11931" in the "zip" field
	When I click "GO"
	Then the page should contain "Suffolk County"
	And the page should contain "$1,200"
	And the page should contain "Now, tell us about your electricity bill"

	When I click "It’s between $100 and $150 a month"
	Then the page should not contain "Now, tell us about your electricity bill"
	Then the page should contain "good savings potential"
	And the page should contain "Last question: Do you own your home?"

	When I click "Yes, I own my home"
	Then the page should contain "low-cost loans and an additional federal tax rebate."
	And the page should contain "We think you’re an excellent fit for exploring solar."

	When I click "Start My Expert Review"
	Then the page should not contain "We think you’re an excellent fit for exploring solar."
	Then the page should contain "Please Fill Out All Fields"
	#And I pause for "1" seconds
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"
	And the page should have a hidden field named "bill" that contains the value "$101-150"
	And the page should have a hidden field named "ownership" that contains the value "Own"
	And the page should have a hidden field named "path" that contains the value "/fit/form"


@hidden-fields
Scenario: Test the full negative flow
	Given I go to "/fit"
	Then the "zip" input should have the placeholder text "Zip Code"
	When I enter "80238" in the "zip" field
	When I click "GO"
	#Then the page should contain "Unable to determine if local incentives are available for Denver County, CO."
	Then the page should contain "A federal tax credit of 30% of the cost of your system is available to homeowners."
	And the page should contain "Now, tell us about your electricity bill"

	When I click "It’s less than $100 a month"
	Then the page should not contain "Now, tell us about your electricity bill"
	#Then the page should contain "$100/month means you have poor savings potential."
	Then the page should contain "Your electric bill of less than $100/month means you have poor savings potential."
	And the page should contain "Last question: Do you own your home?"

	When I click "No, I‘m a renter"
	Then the page should contain "Most companies work only with home owners"
	And the page should contain "Rooftop solar is not the right fit for your home."

	When I click "Learn More about Community Solar"
	Then the page should not contain "Rooftop solar is not the right fit for your home."
	Then the page should contain "Community solar may be a better fit for you"
	And the page should have a hidden field named "bill" that contains the value "$0-50"
	And the page should have a hidden field named "ownership" that contains the value "Rent"
	And the page should have a hidden field named "from" that contains the value "/fit/"
	
@hidden-fields
Scenario: Test Back Button
	Given I go to "/fit"
	Then the "zip" input should have the placeholder text "Zip Code"
	When I enter "21218" in the "zip" field
	When I click "GO"

	Then the page should contain "Baltimore County"
	And the page should contain "$1,000"
	And the page should contain "Now, tell us about your electricity bill"

	When I click "It’s between $151 and $200 a month"
	Then the page should not contain "Now, tell us about your electricity bill"
	Then the page should contain "excellent savings potential"
	And the page should contain "Last question: Do you own your home?"

	When I click "Yes, I own my home"
	Then the page should contain "low-cost loans and an additional federal tax rebate."
	And the page should contain "We think you’re an excellent fit for exploring solar."

	When I click "Start My Expert Review"
	Then the page should not contain "We think you’re an excellent fit for exploring solar."
	Then the page should contain "Please Fill Out All Fields"
	#And I pause for "1" seconds
	And the page should have a hidden field named "universal_leadid" that contains the value "-"
	And the page should have a hidden field named "bill" that contains the value "$151-200"
	And the page should have a hidden field named "ownership" that contains the value "Own"	

	When I click the back button
	Then the page should contain "$1,000 are available in Baltimore County"
	Then the page should contain "electric bill of $151-200/month"
	Then the page should contain "You may also qualify for low-cost loans"
	Then the page should contain "The next step is for an expert to review your roof using satellite imagery"
	
Scenario: Low bill equals poor fit
	Given I go to "/fit"
	When I enter "06516" in the "zip" field
	When I click "GO"
	And the page should contain "Now, tell us about your electricity bill"
	When I click "It’s less than $100 a month"
	Then the page should not contain "Now, tell us about your electricity bill"
	And the page should contain "Last question: Do you own your home?"
	When I click "Yes, I own my home"
	Then the page should contain "We think you’re a poor fit for exploring solar"

Scenario: Renter equals poor fit
	Given I go to "/fit"
	When I enter "06516" in the "zip" field
	When I click "GO"
	And the page should contain "Now, tell us about your electricity bill"
	When I click "It’s more than $200 a month"
	And the page should contain "Last question: Do you own your home?"
	When I click "No, I‘m a renter"
	Then the page should contain "Rooftop solar is not the right fit for your home."

Scenario: MD Zip shows Incentives
	Given I go to "/fit"
	When I enter "21218" in the "zip" field
	When I click "GO"
	And the page should contain "Local installation incentives of up to $1,000 are available in Baltimore County, MD."

Scenario: Legal Text Present
	Given I go to "/fit/form/"
	Then the page should contain "and authorize SolarPulse and/or its partners"

Scenario: Default error states of form
	Given I go to "/fit/form/"
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your Address"
	And the page should contain "Please Enter Your First and Last Name"
	And the page should contain "Please Enter A Valid Phone Number"
	And the page should contain "Please Enter A Valid Email Address"

Scenario: Check geocoding
	Given I go to "/fit/form/"
	When I enter "00000" in the "Your Address" field
	When I click "Start My Free Expert Review"
	Then the page should contain "Could Not Find This Address"

Scenario: Massachusetts Footnote Present
	Given I go to "/fit/"
	Then the page should contain "First, enter your zip code"
	When I enter "02171" in the "zip" field
	When I click "GO"
	Then the page should not contain "First, enter your zip code"
	And the page should contain "Owners of solar PV systems in Massachusetts "

Scenario: Massachusetts Footnote NOT Present
	Given I go to "/fit/"
	Then the page should contain "First, enter your zip code"
	# Long Island
	When I enter "11743" in the "zip" field
	When I click "GO"
	Then the page should not contain "First, enter your zip code"
	And the page should not contain "Owners of solar PV systems in Massachusetts "

Scenario: Address Menu
	Given I go to "/fit/form/"
	When I enter "33" in the "Your Address" field
	And I click on the "Your Address" field
	# the field has to be active to see the menu
	Then the address menu should be visible

@submit @ci-skip
Scenario: Submit CO Address -> Thanks
	Given I go to "/fit/form/"
	Then the page should contain "Please Fill Out All Fields"
	Then the "Your Address" field should not be disabled
	And I enter "335 14th Street, Denver, CO" in the "Your Address" field
	And I enter "test xxxUNKNOWNxxx" in the "name" field
	And I enter "303-555-5555" in the "phone" field
	And I enter "foo@bar.com" in the "email" field
	And I pause for "1" seconds
	When I click "Start My Free Expert Review"
	# And I pause for "5" seconds
	Then the page should not contain "Please Fill Out All Fields"
	Then the page should contain "Please verify your phone number"

@submit	
Scenario: Submit Lead Following User Path
	Given I go to "/fit"
	Then the "zip" input should have the placeholder text "Zip Code"
	When I enter "80211" in the "zip" field
	When I click "GO"
	And the page should contain "Now, tell us about your electricity bill"

	When I click "It’s between $100 and $150 a month"
	Then the page should not contain "Now, tell us about your electricity bill"
	And the page should contain "Last question: Do you own your home?"

	When I click "Yes, I own my home"
	And the page should contain "We think you’re an excellent fit for exploring solar."

	When I click "Start My Expert Review"
	Then the page should not contain "We think you’re an excellent fit for exploring solar."
	Then the page should contain "Please Fill Out All Fields"
	And the page should have a hidden field named "bill" that contains the value "$101-150"
	And the page should have a hidden field named "ownership" that contains the value "Own"
	
	And I enter "229 East Colfax Avenue, Denver, CO" in the "Your Address" field
	And I enter "test xxxUNKNOWNxxx" in the "name" field
	And I enter "303-555-5555" in the "phone" field
	And I enter "foo@bar.com" in the "email" field
	And I pause for "1" seconds
	When I click "Start My Free Expert Review"
	# And I pause for "5" seconds
	Then the page should not contain "Please Fill Out All Fields"
	Then the page should contain "Please verify your phone number"
	

Scenario: Ensure Analytics Are Present
	Given I go to "/fit/"
	# bing
	Then the page should contain the javascript "bat.bing.com/bat.js"
	And the page should contain the javascript "5129832"
	#facebook
	Then the page should contain the javascript "connect.facebook.net/en_US/fbevents.js"
	And the page should contain the javascript "fbq('init', '242423486092688');"
	# google_conversion_id
	Then the page should contain the script "//www.googleadservices.com/pagead/conversion.js"
	And the page should contain the javascript "var google_remarketing_only = true;"

Scenario: Solar Info Landing Page
	Given I go to "/fit/solar-info"
	Then the page should contain "Millions are changing their bills – and the world – with solar panels."
	When I click "Check Your Solar Fit"
	Then the page should contain "Answer three quick questions to check your solar fit."


