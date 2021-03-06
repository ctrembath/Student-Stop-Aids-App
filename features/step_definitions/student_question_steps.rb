Given(/^there are no users$/) do
  expect(User.all.count).to eq(0)
end

When(/^I submit my details$/) do
  post "users/",    :email => 'user@example.com'
end

Then(/^I am registered as a user$/) do
   pending # expect(User.all.count).to eq(1)
end

Given(/^we have some questions with choices for some candidates$/) do
  step 'we have some questions with choices'
  step 'we have some candidates'
end

When(/^all the questions are answered for the first candidate$/) do
  Question.all.each {|question| question.create_answer(@alice, question.choices.first)}
end

Then(/^I see no questions for the candidate$/) do
  expect(page).to_not have_content('red pill')
  expect(page).to_not have_content('war or famine')
  expect(page).to_not have_content('beef or chicken')
end



