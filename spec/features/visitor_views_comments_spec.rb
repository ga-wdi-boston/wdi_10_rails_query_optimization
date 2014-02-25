require 'rails_helper'

feature 'Visitor views comments on an article' do
  scenario 'with score, submitter, and date' do
    comment = create_comment_with_votes(5, 3, created_at: 3.days.ago)

    visit root_path
    within('div', text: comment.article.title) { click_link '1 comment' }

    within('div') do
      expect(page).to have_content "2 points by #{comment.user.email} 3 days ago"
    end
  end

  scenario 'ordered by highest score first' do
    article = create(:article)
    okay_comment = create_comment_with_votes(5, 1, article: article) # 4 points
    cool_comment = create_comment_with_votes(10, 2, article: article) # 8 points
    lame_comment = create_comment_with_votes(1, 3, article: article) # -2 points

    visit root_path
    within('div', text: article.title) { click_link '3 comments' }

    expect(page).to have_content(
      /#{cool_comment.body}.*#{okay_comment.body}.*#{lame_comment.body}/
    )
  end

  # It's sometimes useful to define helper methods like this inside a
  # `feature` block. They are accessible only to scenarios within the feature.
  def create_comment_with_votes(upvotes, downvotes, **attributes)
    comment = create(:comment, attributes)
    create_list(:vote, upvotes, votable: comment, direction: 'up')
    create_list(:vote, downvotes, votable: comment, direction: 'down')
    comment
  end
end
