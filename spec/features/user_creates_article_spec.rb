require 'rails_helper'

feature 'User creates an article' do
  scenario 'unsuccessfully when not signed in' do
    visit root_path
    expect(page).to_not have_link 'Submit article'

    visit new_article_path
    expect(page).to_not have_button 'Create Article'
    expect(page).to have_content 'You need to sign in or sign up'
  end

  context 'when signed in' do
    background do
      @user = create(:user)
      sign_in_as(@user)
      click_link 'Submit article'
    end

    scenario 'successfully' do
      fill_in 'Title', with: 'Better Specs!'
      fill_in 'URL', with: 'http://betterspecs.org'
      click_button 'Create Article'

      expect(page).to have_content 'Article submitted!'
      expect(page).to have_link 'Better Specs!', href: 'http://betterspecs.org'
      expect(page).to have_content "by #{@user.email} less than a minute ago"
    end

    scenario 'unsuccessfully with an invalid URL' do
      fill_in 'URL', with: 'ftp://haxxored.info'
      click_button 'Create Article'

      expect(page).to_not have_content 'Article submitted!'
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Url is not a valid URL"
    end
  end
end
