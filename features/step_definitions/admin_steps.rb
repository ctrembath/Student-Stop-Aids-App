When(/^the administrator adds a question by api$/) do
  post "/questions", :ask_text => "do you like pizza or kebabs"
end

Then(/^I get JSON kebab question text$/) do
  expect(page).to have_content("pizza or kebabs")
end

When(/^the administrator edits candidate name$/) do
  patch "/candidates/#{@alice.id}",  :name => "changed" 
end

Then(/^we see the updated information for candidate$/) do
  visit "/candidates/#{@alice.id}"
  expect(page).not_to have_content 'Alice'
  expect(page).to have_content 'changed'
end

When(/^the administrator adds candidate twitter$/) do
  patch "/candidates/#{@alice.id}",  :twitter => "LookingGlass"
end

Then(/^we see the twitter information for candidate$/) do
  visit "/candidates/#{@alice.id}"
  expect(page).to have_content 'LookingGlass'
end

When(/^we have a candidate in a constituency$/) do
  step('we have a constituency')
  @alice = Candidate.create(name: 'Alice', constituency_id: @constituency.id)
end

When(/^the administrator adds a candidate$/) do
  post "/candidates", :name => "Bob", :constituency_id => @constituency.id
end

When(/^the administrator deletes the candidate$/) do
   delete "/candidates/#{@alice.id}"
end

Then(/^we don't see the candidate in candidate data view$/) do
visit "/constituencies/#{@constituency.id}/candidates"
expect(page).not_to have_content("Alice")
end

When(/^the administrator deletes first question by api$/) do
  delete "/questions/#{@red_or_blue.id}"
end

Then(/^I don't see the first question$/) do
  expect(page).to_not have_content('red pill or blue')
end

