require 'rails_helper'

feature 'User votes an article' do
  scenario 'up' do
    target_article = create_list(:article, 3).second
    sign_in_as(create(:user))

    within('div', text: target_article.title) { click_link 'Upvote' }

    within('div', text: target_article.title) do
      expect(page).to have_content '1 point'
    end
  end
end
