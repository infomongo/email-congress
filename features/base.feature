Feature: Website tests
from the micro site

Scenario: Website Index
	Given I go to "http://infomongo.com"
	Then the page should contain "Solar, Simplified."

