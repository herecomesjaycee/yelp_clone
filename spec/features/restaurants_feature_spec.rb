require 'rails_helper'


feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      create_restaurant
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

scenario 'user is not logged in/sign up, cannot create new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    before do
      create_restaurant
    end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
    end
  end

  context 'editing restaurants ' do
    before  do
      create_restaurant
      click_link 'Sign out'
    end
    scenario ' let a user edit a restaurant - limited to user created it - positive' do
      visit '/restaurants'
      sign_in
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
    end
    scenario ' let a user edit a restaurant - limited to user created it - negative' do
      visit '/restaurants'
      click_link 'Edit KFC'
      expect(current_path).to eq '/users/sign_in'
  end

end

  context 'deleting restaurants' do

    before  do
      create_restaurant
      click_link 'Sign out'
    end

    scenario 'removes a restaurant when a user clicks a delete link - limited to user created it - negative' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content 'Sign in'
      expect(page).to_not have_content 'Restaurant deleted successfully'
    end

     scenario 'removes a restaurant when a user clicks a delete link - limited to user created it - positive' do
      visit '/restaurants'
      sign_in
      click_link 'Delete KFC'
      expect(page).to_not have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
