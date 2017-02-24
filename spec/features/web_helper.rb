def sign_up
	visit('/restaurants')
	click_link('Sign up')
	fill_in("Email", with: "bob@example.com")
	fill_in("Password", with: "123456789")
	fill_in("Password confirmation", with: "123456789")
	click_button("Sign up")
end

def create_restaurant
	sign_up
	click_link 'Add a restaurant'
	fill_in 'Name', with: 'KFC'
	click_button 'Create Restaurant'
end

def sign_in
	   click_link 'Sign in'
      fill_in("Email", with: "bob@example.com")
      fill_in("Password", with: "123456789")
      click_button 'Log in'
end