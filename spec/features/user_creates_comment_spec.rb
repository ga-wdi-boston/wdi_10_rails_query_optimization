require 'rails_helper'

feature 'User comments on an article' do
  background do
    @article = create(:article)
  end

  scenario 'unsuccessfully when not signed in' do
    visit root_path
    click_link '0 comments'
    expect(page).to_not have_button 'Add Comment'
  end

  context 'when signed in' do
    background do
      @user = create(:user)
      sign_in_as(@user)
      visit root_path
      click_link '0 comments'
    end

    scenario 'successfully' do
      fill_in 'Enter comment...', with: 'Get off my lawn!'
      click_button 'Add Comment'

      expect(page).to have_content 'Comment added!'
      within('div', text: 'Get off my lawn!') do
        expect(page).to have_content "by #{@user.email} less than a minute ago"
      end
    end

    scenario 'unsuccessfully with a blank body' do
      click_button 'Add Comment'

      expect(page).to_not have_content 'Comment added!'
      expect(page).to have_content "Body can't be blank"
    end
  end
end
