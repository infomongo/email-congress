Feature: Testing 'Free Quote'

Scenario: Test Zip Input
	Given I go to "/free-quote"
	Then the "zip" input should have the placeholder text "90210"
	Then I click the Continue button
	Then the page should contain "Please enter your zip code."

Scenario: Testing Ownership
	Given I go to "/free-quote"
	When I click "No, I rent my home."
	Then the page should contain "Solar companies only work with home owners."

Scenario: Test Zip Input 2
	Given I go to "/free-quote"
	When I enter "requ" in the "zip" field
	Then I click the Continue button
	Then the page should contain "Please enter a valid zip code."

@submit
Scenario: Full Flow
	Given I go to "/free-quote/?boom=town"
	And I pause for "1" seconds
	When I enter "90210" in the "zip" field
	Then I click the Continue button

	Then the page should contain "STEP TWO"
	And I pause for "1" seconds
	And I select "$301-400" from the "What is your average monthly electric bill?" menu
	And I select "PacifiCorp" from the "Who is your electric utility company?" menu
	And I select "A Little Shade" from the "How shaded is your roof?" menu

	Then I click the Continue button
	Then the page should contain "STEP THREE"
	And I pause for "1" seconds

	Then the page should have a hidden field named "universal_leadid" that contains the value "-"
	Then the page should have a hidden field named "ownership" that contains the value "Own"
	Then the page should have a hidden field named "utility" that contains the value "PacifiCorp"
	Then the page should have a hidden field named "shade" that contains the value "A Little Shade"
	Then the page should have a hidden field named "boom" that contains the value "town"

	When I enter "3651 Inglewood Blvd Los Angeles, CA" in the "Your Address" field
	When I enter "Test xxxUNKNOWNxxx" in the "First and Last Name" field
	When I enter "boot@root.jp" in the "Your Email" field
	When I enter "3035555555" in the "Your Phone Number" field
	And I click "Get My Free Quote"

	Then the page should not contain "STEP THREE"
	Then the page should contain "323-306-5511"

Scenario: Error Checking Including Two Names Check
	Given I go to "/free-quote/?boom=town"
	And I pause for "1" seconds
	When I enter "90210" in the "zip" field
	Then I click the Continue button

	Then the page should contain "STEP TWO"
	And I pause for "1" seconds
	Then I click the Continue button

	Then the page should contain "STEP THREE"
	And I pause for "1" seconds
	And I click "Get My Free Quote"

	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Email Address"
	Then the page should contain "Please Enter A Valid Phone Number"

	And I enter "sam" in the "First and Last Name" field
	And I enter "moo" in the "Your Email" field
	And I enter "303" in the "Your Phone Number" field

	And I click "Get My Free Quote"

	Then the page should contain "Please Enter Your Address"
	Then the page should contain "Please Enter Your First and Last Name"
	Then the page should contain "Please Enter A Valid Email Address"
	Then the page should contain "Please Enter A Valid Phone Number"
