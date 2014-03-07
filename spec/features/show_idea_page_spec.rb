require 'spec_helper'

describe 'Test idea page'  do	
	before(:each) do
	    @user = add_sample_user "Jacky", "Mok", email, password
	    sign_in_with(email, password)
	    @idea = add_idea_directly("TITLE", "DESCRIPTION", @user)
	    visit idea_path(@idea)
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
		visit idea_path(@idea)
		expect(page).should have_selector("span.liked_idea");
	end

	it 'should have user name on idea post' do
		expect(page).should have_content("ago by #{@user.first_name} #{@user.last_name}")
	end

	it 'should add comment when clicked' do
		fill_in 'Content', with: "blah"

  		expect do
			click_button "Submit"
		end.to change(@idea.comments, :count).by(1)

  		expect(page).should have_content("blah");
	end

	it 'should add comment and show correct comment count in ideas page' do
		add_comment_directly(@user, @idea, "blah")
		visit user_path(@user)

		expect(page).should have_content("1 | Posted")
	end


end

describe 'Test idea page not signed in'  do
	before(:each) do
	    @user = add_sample_user "Jacky", "Mok", email, password
	    @idea = add_idea_directly("TITLE", "DESCRIPTION", @user)
	    visit idea_path(@idea)
	end
	it 'should disable like button when not signed in' do
		first('.jumbotron button')[:disabled].should eq "disabled"
	end
	it 'should not be able to comment when not signed in' do
		expect(page).should_not have_selector("form input.btn")
	end 
end