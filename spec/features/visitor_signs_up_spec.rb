require 'spec_helper'

describe 'Visitor signs up'  do
	it 'with valid email and password' do
		sign_up_with 'first','last', 'valid@example.com', 'password', 'password';
		expect(page).to have_content('Sign out');
		expect(page).should have_selector('h1', :text => 'first last')
	end

	it 'with invalid email and password' do
		sign_up_with 'first','last', 'invalid', 'password', 'password';
		expect(page).to have_content('Sign in');
	end

	it 'with blank password' do
		sign_up_with 'first','last', 'invalid', '', '';
		expect(page).to have_content('Sign in');
	end

	it 'with mismatched password' do
		sign_up_with 'first','last', 'invalid', '', 'password';
		expect(page).to have_content('Sign in');
	end
end

