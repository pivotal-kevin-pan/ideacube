require 'spec_helper'

describe 'Test user page'  do	
	before(:each) do
	    @user = add_sample_user "Jacky", "Mok", email, password
	    sign_in_with(email, password)
	    @idea = add_idea_directly("TITLE", "DESCRIPTION", @user)
	    visit user_path(@user)
	end

	it 'should have name and add idea button' do
		expect(page).should have_selector('h1', text: "#{@user.first_name} #{@user.last_name}")
		expect(page).should have_selector("a", text: "Have an idea?")
	end

	it 'should be able to like an idea' do
		expect(page).should have_content("0");
		expect(page).should_not have_selector("span.liked_idea");

		expect do
            click_button "like"
          end.to change(@user.likes, :count).by(1)

        expect(page).should have_content("1");
        expect(page).should have_selector("span.liked_idea");
	end

	it 'should be able to see red heart when idea is liked' do
		add_like_directly(@user, @idea)

		visit user_path(@user)

		expect(page).should have_selector("span.liked_idea");
	end

	it 'should open idea when clicked' do
		first(".caption a").click
		expect(page).should have_content(@idea.title);
		expect(page).should have_content(@idea.description);
		expect(page).should_not have_content("Have an Idea?");

		
		
		fill_in 'Content', with: "blah"
  		click_button 'Submit'

		# FIXME expect(page).should have_selector("input", value: "Submit")
	end

	it 'should have zero comments for idea' do
		expect(page).should have_content("0 | Posted")
	end

	it 'should have user name on idea post' do
		expect(page).should have_content("ago by #{@user.first_name} #{@user.last_name}")
	end
end