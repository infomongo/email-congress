Feature: Testing Learn More Form

Scenario: Link Works, Legal Text & Basic Error Checking
	Given I go to "/learn-more"
	Then the page should contain "Start My Free Expert Review"
	And the page should contain "and authorize SolarPulse and/or its partners"
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Phone Number"
	And the page should contain "Please Enter A Valid Email Address"

Scenario: Make sure two words are in name field
	Given I go to "/learn-more"
	And I enter "test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Enter Your First and Last Name"

	And I enter "test test" in the "First and Last Name" field
	When I click "Start My Free Expert Review"
	Then the page should not contain "Please Enter Your First and Last Name"

Scenario: Can't Submit a Zip in the Lead Form
	Given I go to "/learn-more"
	And I enter "06516" in the "Your Address" field
	And I enter "test test" in the "First and Last Name" field
	And I enter "5555555555" in the "Your Phone Number" field
	When I click "Start My Free Expert Review"
	And the "Your Address" field should have the value "06516"
	Then the page should contain "Could Not Find This Address"
	And the "Your Phone Number" field should have the value "555-555-5555"
	And the "First and Last Name" field should have the value "test test"
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"

@submit @ci-skip
Scenario: Submit CO Address -> Thanks
	Given I go to "/learn-more/"
	Then the page should contain "Please Fill Out All Fields"
	Then the "Your Address" field should not be disabled
	And I enter "335 14th Street, Denver, CO" in the "Your Address" field
	And I enter "test xxxUNKNOWNxxx" in the "First and Last Name" field
	And I enter "303-555-5555" in the "Your Phone Number" field
	And I enter "foo@bar.com" in the "email" field
	And I pause for "1" seconds
	When I click "Start My Free Expert Review"
	#And I pause for "5" seconds
	Then the page should not contain "Please Fill Out All Fields"
	Then the page should contain "Please verify your phone number"

Scenario: Hidden Fields Created
	Given I go to "/learn-more/?pump=dump&cat=bag"
	Then the page should contain "Start My Free Expert Review"
	Then the page should have a hidden field named "pump" with the value "dump"
	Then the page should have a hidden field named "cat" with the value "bag"

Scenario: Hidden Fields Created from Going Solar Page
	Given I go to "/goingsolar/maryland/"
	Then the page should contain "Going Solar in Maryland"
	Then the page should contain "Ready to learn more about rooftop solar panels in Maryland?"
	When I click "Start My Free Expert Review"
	Then the page should contain "Please Fill Out All Fields"
	Then the page should have a hidden field named "from" with the value "going-solar-md"
