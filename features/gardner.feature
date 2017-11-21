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
	# And I select "Insurance Health" from the "Message Topic" menu
	And I select "Commerce" from the "Message Topic" menu
	And I enter "I am urging you to consider…" in the "Message Subject" field
	And I find the text area "Message*" and set it to 
	"""
Senator Gardner,

I’m writing today to urge you to publicly oppose the FCC’s plan to end Net Neutrality. In countries without this protection, like Portugal, consumers pay higher prices for worse service.

The open internet has been a boon to business. I have spent the last 20 years working in technology and on the web. Net Neutrality protects free speech and innovation. Ending it only benefits large ISPs. We need more competition in broadband internet. In Denver, Comcast and CenturyLink have a duopoly on providing broadband internet access. This only makes them stronger and less responsive to customers.

Please speak out against the FCC’s plan to end Net Neutrality.

Thanks,
John Phillips
	"""
	
	And I pause for "2" seconds
	
	When I click "Submit"

	Then the page should contain "Thank You"

