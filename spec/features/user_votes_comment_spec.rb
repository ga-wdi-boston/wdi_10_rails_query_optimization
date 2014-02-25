require 'rails_helper'

feature 'User votes a comment' do
  background do
    @user = create(:user)
    @comment = create(:comment)
  end

  scenario 'unsuccessfully when not signed in' do
    visit root_path
    within('div', text: @comment.article.title) { click_link '1 comment' }

    within('div', text: @comment.body) do
      expect(page).to_not have_link 'Upvote'
      expect(page).to_not have_link 'Downvote'
    end

    page.driver.submit(:patch, comment_vote_path(@comment), { direction: 'up' })
    expect(page).to have_content 'You need to sign in or sign up'
  end

  # Defining a helper method accessible only to scenarios within this feature
  def view_comments
    sign_in_as(@user)
    within('div', text: @comment.article.title) { click_link '1 comment' }
  end

  context 'up' do
    scenario 'from neutral' do
      view_comments

      within('div', text: @comment.body) { click_link 'Upvote' }

      within('div', text: @comment.body) do
        expect(page).to have_content '1 point'
      end
    end

    scenario 'from down' do
      create(:vote, user: @user, votable: @comment, direction: 'down')
      view_comments

      within('div', text: @comment.body) { click_link 'Upvote' }

      within('div', text: @comment.body) do
        expect(page).to have_content '1 point'
      end
    end
  end

  context 'down' do
    scenario 'from neutral' do
      view_comments

      within('div', text: @comment.body) { click_link 'Downvote' }

      within('div', text: @comment.body) do
        expect(page).to have_content '-1 points'
      end
    end

    scenario 'from up' do
      create(:vote, user: @user, votable: @comment, direction: 'up')
      view_comments

      within('div', text: @comment.body) { click_link 'Downvote' }

      within('div', text: @comment.body) do
        expect(page).to have_content '-1 points'
      end
    end
  end

  context 'neutral' do
    scenario 'from up' do
      create(:vote, user: @user, votable: @comment, direction: 'up')
      view_comments

      within('div', text: @comment.body) { click_link 'Upvote' }

      within('div', text: @comment.body) do
        expect(page).to have_content '0 points'
      end
    end

    scenario 'from down' do
      create(:vote, user: @user, votable: @comment, direction: 'down')
      view_comments

      within('div', text: @comment.body) { click_link 'Downvote' }

      within('div', text: @comment.body) do
        expect(page).to have_content '0 points'
      end
    end
  end
end
