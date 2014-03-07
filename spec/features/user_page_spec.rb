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

	it 'should allow you to favorite an idea on another user\'s page' do
		@user2 = add_sample_user "Kevin", "Pan", "xpan@pivotallabs.com", "password"
		sign_in_with("xpan@pivotallabs.com", "password")

		visit user_path(@user)

		expect(page).should have_content("0");
		expect(page).should_not have_selector("span.liked_idea");

		expect do
            click_button "like"
          end.to change(@user2.likes, :count).by(1)

        expect(page).should have_content("1");
        expect(page).should have_selector("span.liked_idea");
	end

	it 'should redirect to create idea when clicked' do
		click_link 'Have an idea?'
		expect(page).should have_content("Add an Idea!");
	end

	it 'should paginate after having more than 5 ideas' do
		(1..5).each do |i|
			add_idea_directly(i, i, @user)
		end

		visit user_path(@user)

		expect(page).should have_selector(".pagination")
	end
end

describe 'Test user page not signed in'  do
	before(:each) do
	    @user = add_sample_user "Jacky", "Mok", email, password
	    @idea = add_idea_directly("TITLE", "DESCRIPTION", @user)
	    visit user_path(@user)
	end
	it 'should not have the add an idea button' do
		expect(page).should_not have_selector(".add_an_idea_button_parent")
	end

	it 'should not allow me to like an idea' do
		first('form button')[:disabled].should eq "disabled"
		expect(page).should have_content("0");
		expect(page).should_not have_selector("span.liked_idea");
	end

	it 'should not have add an idea button when looking at someone else\'s profile' do
		@user2 = add_sample_user "Kevin", "Pan", "xpan@pivotallabs.com", "password"
		sign_in_with(email, password)

		visit user_path(@user2)

		expect(page).should_not have_selector(".add_an_idea_button_parent")
	end
end