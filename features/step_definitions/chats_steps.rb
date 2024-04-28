# frozen_string_literal: true

Given "I am on the home page" do
  visit "/"
end

Then "I should see {string}" do |content|
  expect(page).to have_content(content)
end
