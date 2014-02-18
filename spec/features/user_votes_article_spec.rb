require 'rails_helper'

feature 'User votes an article' do
  background do
    @user = create(:user)
    @article = create(:article)
  end

  # Contexts are useful for organizing scenarios within a feature.
  # They can contain their own `background` blocks to share setup for
  # scenarios within them, though I'm not doing that here.
  context 'up' do
    scenario 'from neutral' do
      sign_in_as(@user)

      within('div', text: @article.title) { click_link 'Upvote' }

      within('div', text: @article.title) do
        expect(page).to have_content '1 point'
      end
    end

    scenario 'from down' do
      create(:vote, user: @user, votable: @article, direction: 'down')
      sign_in_as(@user)

      within('div', text: @article.title) { click_link 'Upvote' }

      within('div', text: @article.title) do
        expect(page).to have_content '1 point'
      end
    end
  end

  context 'down' do
    scenario 'from neutral' do
      sign_in_as(@user)

      within('div', text: @article.title) { click_link 'Downvote' }

      within('div', text: @article.title) do
        expect(page).to have_content '-1 points'
      end
    end

    scenario 'from up' do
      create(:vote, user: @user, votable: @article, direction: 'up')
      sign_in_as(@user)

      within('div', text: @article.title) { click_link 'Downvote' }

      within('div', text: @article.title) do
        expect(page).to have_content '-1 points'
      end
    end
  end

  context 'neutral' do
    scenario 'from up' do
      create(:vote, user: @user, votable: @article, direction: 'up')
      sign_in_as(@user)

      within('div', text: @article.title) { click_link 'Upvote' }

      within('div', text: @article.title) do
        expect(page).to have_content '0 points'
      end
    end

    scenario 'from down' do
      create(:vote, user: @user, votable: @article, direction: 'down')
      sign_in_as(@user)

      within('div', text: @article.title) { click_link 'Downvote' }

      within('div', text: @article.title) do
        expect(page).to have_content '0 points'
      end
    end
  end
end
