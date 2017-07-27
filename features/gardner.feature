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
	
	It seems like the senate is trying to use this bill as an sort of "end run" around the process. The idea is that this bill will pass and then there will be a conference with the house.
	
	This is a bad idea, for several reasons. 1) The house could pass the bill as is an send it to the president. 2) In conference, if no alternate agreement is reached, then the bill will be sent to the President. 3) If a small group of representatives want the bill to pass, all they need to do is block progress on alternatives.
	
	So please, only vote for the 'skinny repeal' if you are happy passing it. Becuase it will become likely to pass if the senate votes for it.
	
	Wouldn't it be better to slow down, and work on a replacement or an improved version of the bill in a more orderly fashion?
	"""
	
	And I pause for "2" seconds
	
	When I click "Submit"

	Then the page should contain "Thank You"

