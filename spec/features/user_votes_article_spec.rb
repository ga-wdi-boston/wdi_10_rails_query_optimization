require 'rails_helper'

feature 'User votes an article' do
  background do
    @target_article = create_list(:article, 3).second
  end

  scenario 'up' do
    sign_in_as(create(:user))

    within('div', text: @target_article.title) { click_link 'Upvote' }

    within('div', text: @target_article.title) do
      expect(page).to have_content '1 point'
    end
  end

  scenario 'neutral from up' do
    user = create(:user)
    create(:vote, user: user, votable: @target_article, direction: 'up')
    sign_in_as(user)

    within('div', text: @target_article.title) { click_link 'Upvote' }

    within('div', text: @target_article.title) do
      expect(page).to have_content '0 points'
    end
  end
end
