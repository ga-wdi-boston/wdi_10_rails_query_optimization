require 'rails_helper'

feature 'User votes an article' do
  background do
    @target_article = create_list(:article, 3).second
  end

  context 'up' do
    scenario 'successfully' do
      sign_in_as(create(:user))

      within('div', text: @target_article.title) { click_link 'Upvote' }

      within('div', text: @target_article.title) do
        expect(page).to have_content '1 point'
      end
    end

    scenario 'unsuccessfully due to already having voted' do
      user = create(:user)
      create(:vote, votable: @target_article, direction: 1)
      create(:vote, user: user, votable: @target_article, direction: 1)
      sign_in_as(user)

      within('div', text: @target_article.title) { click_link 'Upvote' }

      within('div', text: @target_article.title) do
        expect(page).to have_content '2 points'
      end
    end
  end
end
