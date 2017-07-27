Feature: Email Cory Gardner
From his Senate site https://www.gardner.senate.gov/

Scenario: Email Cory Gardner
	Given I go to "https://www.gardner.senate.gov/contact-cory/email-cory"
	Then the page should contain "Contact Cory"
	And I select "Share your opinions or comment on legislation or issues" from the "actions" menu
	
	Then the page should contain "Your Name"
	And I select "Mr." from the "Prefix" menu
	And I enter "John" in the "First Name" field
	And I enter "Phillips" in the "Last Name" field
	And I enter "3844 Clay Street" in the "Street Address*" field
	And I enter "Denver" in the "City" field
	And I enter "80211" in the "Zip" field
	And I enter "303-555-1212" in the "Phone Number*" field
	And I enter "nospam@infomongo.com" in the "Email*" field
	And I enter "nospam@infomongo.com" in the "Verify Email" field
	And I select "Insurance Health" from the "Message Topic" menu
	And I enter "I am urging you to consider…" in the "Message Subject" field
	And I find the text area "Message*" and set it to 
	"""
	I'm writing today to urge you to vote no on the 'skinny repeal' healthcare bill.
	
	If the bill passes it will do significant harm to Coloradans. I'm worried that the house will pass the bill unchanged, even though this is mostly a political tactic to take the bill into committee.
	
	This is a bad bill. You have already voted for 'repeal and replace' and straight repeal. You can convincingly claim to have fought to repeal Obamacare. This is not repeal. This is Obamacare light.
	
	Do the right things for Colorado. Show some leadership and act like an adult. The right thing to do at this point is to fix the flaws in Obamacare.
	"""
	
	And I pause for "2" seconds
	
	When I click "Submit"

	Then the page should contain "Thank You"

