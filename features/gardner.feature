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
Dear Mr. Gardner,

In my opinion you were wrong to vote for the Repeal/Replace bill. You were wrong on the Repeal-only bill. You were double extra wrong on the Skinny Repeal vote.

What we need are group of more moderate centrists to work across party lines. I had hoped that you would be that kind of Senator.

That would take courage though. You have to stick your neck out to work across the aisle. So far we haven’t seen much courage out of you.

Maybe Graham’s more state centered approach to Healthcare could work? Maybe you could even find a large group in the center for this? I don’t know.

Maybe the answer is to get to work on fixing the problems in Obamacare. It’s not the leftist system is has been sold as. And it definitely has problems. There is work to done.

Here’s hoping we can expect better from you,

John Phillips
Colorado Native and long time Sunnyside Resident.
	"""
	
	And I pause for "2" seconds
	
	When I click "Submit"

	Then the page should contain "Thank You"

