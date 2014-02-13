require 'rails_helper'

feature 'User creates an article' do
  scenario 'successfully' do
    user = create(:user)
    sign_in_as(user)

    click_link 'Submit article'
    fill_in 'Title', with: 'Better Specs!'
    fill_in 'URL', with: 'http://betterspecs.org'
    click_button 'Create Article'

    expect(page).to have_link 'Better Specs!', href: 'http://betterspecs.org'
    expect(page).to have_content "by #{user.email} less than a minute ago"
  end
end
