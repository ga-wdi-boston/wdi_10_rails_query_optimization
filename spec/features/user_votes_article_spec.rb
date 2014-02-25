require 'rails_helper'

feature 'User votes an article' do
  background do
    @user = create(:user)
    @article = create(:article)
  end

  scenario 'unsuccessfully when not signed in' do
    visit root_path
    within('div', text: @article.title) do
      expect(page).to_not have_link 'Upvote'
      expect(page).to_not have_link 'Downvote'
    end

    page.driver.submit(:patch, article_vote_path(@article), { direction: 'up' })
    expect(page).to have_content 'You need to sign in or sign up'
  end

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
