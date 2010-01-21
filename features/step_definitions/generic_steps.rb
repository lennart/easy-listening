Given /^I am a generic user$/ do
end

When /^I visit "([^\"]*)"$/ do |path|
  visit path
end

Then /^I should see "([^\"]*)"$/ do |content|
  page.should have_content(content)
end

