Given(/^I am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I follow "(.*?)"$/) do |link|
  click_link(link)
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content(content)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, :with => value)
end

When(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

