require 'rails_helper'

feature 'User votes a comment' do
  background do
    @user = create(:user)
    @comment = create(:comment)
    sign_in_as(@user)
  end

  # Defining a helper method accessible only to scenarios within this feature
  def view_comments
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
