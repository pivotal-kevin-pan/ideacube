require 'spec_helper'

describe 'Vistor signs in'  do	
	before(:each) do
	    @user = add_sample_user "Jacky", "Mok", email, password
	end

	it 'should sign in with valid email and password' do
		sign_in_with(email, password)
		expect(page).to have_content('Sign out')
	end

	it 'should not sign in with invalid email' do
		sign_in_with(email + "abc", password)
		expect(page).to have_content('Sign in')
	end

	it 'should not sign in with invalid password' do
		sign_in_with(email, "invalid")
		expect(page).to have_content('Sign in')
	end
end