require 'spec_helper'

describe 'Add idea'  do	
	before(:each) do
	    @user = add_sample_user "Jacky", "Mok", email, password
	    sign_in_with(email, password)
	    visit new_idea_path
	end

	it 'should add valid idea' do
		idea_count_before = Idea.all.count
	    add_idea_with 'TITLE', 'DESCRIPTION'
	    expect(page).should have_selector('h3', :text => 'TITLE')
	    expect(page).should have_selector('p', :text => 'DESCRIPTION')
	    Idea.all.count.should equal(idea_count_before + 1)

	end

	it 'should not add invalid idea' do
		idea_count_before = Idea.all.count
	    add_idea_with '', ''
	    expect(page).should have_content('Add an Idea!')
	    expect(page).should have_content('Description can\'t be blank')
	    expect(page).should have_content('Title can\'t be blank')
	    Idea.all.count.should equal(idea_count_before)
	end
end