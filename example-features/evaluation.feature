Feature: Testing 'Evaluation'

@animation
Scenario: Test the full positive flow
	Given I go to "/evaluation"
	When I click "Own"

	Then the page should contain "What is your ZIP code?"
	When I enter "11931" in the "zip" field
	When I click "Next Question"

	Then the page should contain "What is your average monthly electricity bill?"
	Then I select "$201 - $300" from the "monthly_electric" menu
	Then I select "A Little Shade" from the "roof_shade" menu

	And I click "Next Question"

	Then the page should contain "Checking qualifications"
	Then the page should contain "Congratulations"

	When I enter "8764 E. 29th Pl, 80238" in the "Your Address" field
	And I enter "Test xxxUNKNOWNxxx" in the "First and Last Name" field
	And I enter "test@test.com" in the "Email Address" field
	And I click "Next Question"

	Then the page should contain "Your Phone Number"
	And I enter "303-555-5555" in the "Your Phone Number" field
	Then the page should have a hidden field named "universal_leadid" that contains the value "-"
	When I click "Get Free Quote"

	Then the page should contain "Please verify your phone number"

@animation
Scenario: Can't submit just a zip on the Address + Name + Email card
	Given I go to "/evaluation"
	When I click "Own"

	Then the page should contain "What is your ZIP code?"
	When I enter "11931" in the "zip" field
	When I click "Next Question"

	Then the page should contain "What is your average monthly electricity bill?"
	When I click "Next Question"

	Then the page should contain "Checking qualifications"
	Then the page should contain "Congratulations"

	When I enter "11931" in the "Your Address" field
	And I enter "test test" in the "First and Last Name" field
	And I enter "test@test.com" in the "Email Address" field
	When I click "Next Question"
	Then the page should contain "Please enter a valid address"

Scenario: Make sure two words are getting filled out for name
	Given I go to "/evaluation/#/form"
	And I enter "test" in the "First and Last Name" field
	When I click "Next Question"
	Then the page should contain "Please enter your full name"

	And I enter "test test" in the "First and Last Name" field
	When I click "Next Question"
	Then the page should not contain "Please enter your full name"

Scenario: Click Rent
	Given I go to "/evaluation"
	When I click "Rent"
	Then the page should contain "Community solar may be a better fit for you."

Scenario: Test Form
	Given I go to "/evaluation/#/form"
	When I click "Next Question"
	Then the page should contain "Please enter an address"
	Then the page should contain "Please enter your full name"
	Then the page should contain "Please enter an email"

Scenario: Test Phone
	Given I go to "/evaluation/#/phone"
	When I click "Get Free Quote"
	Then the page should contain "This number can not be called"
