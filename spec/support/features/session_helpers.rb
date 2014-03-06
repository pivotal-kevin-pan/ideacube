module Features
  module SessionHelpers

    @@email = "jmok@pivotallabs.com"
    @@password = "12345678"

    def sign_up_with (first,last,email,password,password_confirm)
  		visit new_user_path
  		fill_in 'First name', with: first
  		fill_in 'Last name', with: last
  		fill_in 'Email', with: email
  		fill_in 'Password', with: password
  		fill_in 'Confirm Password', with: password_confirm
  		click_button 'Create my account'
  	end

    def sign_in_with (email,password)
      visit new_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

    def add_idea_with (title, description)
      fill_in 'Title', with: title
      fill_in 'Description', with: description
      click_button 'Add Idea'
    end

    def add_idea_directly(title, description, user)
      Idea.create(user_id: user.id, title: title, description: description)
    end

    def add_like_directly(user, idea)
      Like.create(user_id: user.id, idea_id: idea.id)
    end

    def add_sample_user(first,last,email,password)
      user = User.create(first_name: first, last_name: last, password: password, password_confirmation: password, email: email)
    end

    def add_comment_directly(user, idea, comment)
      Comment.create(content: comment, idea_id: idea.id, user_id: user.id)
    end

    def email
      @@email
    end

    def password
      @@password
    end
  end
end