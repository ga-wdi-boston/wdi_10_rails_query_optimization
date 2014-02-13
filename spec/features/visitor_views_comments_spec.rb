require 'rails_helper'

feature 'Visitor views comments on an article' do
  scenario 'with submitter and date' do
    comment = create(:comment, created_at: 2.days.ago)

    visit root_path
    within('div', text: comment.article.title) { click_link '1 comment' }

    within('div', text: comment.body) do
      expect(page).to have_content "by #{comment.user.email} 2 days ago"
    end
  end
end
