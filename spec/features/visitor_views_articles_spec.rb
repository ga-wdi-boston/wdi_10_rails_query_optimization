require 'rails_helper'

feature 'Visitor views all articles on the home page' do
  scenario 'ordered by most recent first' do
    new_article = create(:article, created_at: 3.days.ago)
    very_new_article = create(:article, created_at: 2.days.ago)
    old_article = create(:article, created_at: 5.days.ago)

    visit root_path

    expect(page).to have_content(
      /#{very_new_article.title}.*#{new_article.title}.*#{old_article.title}/
    )
  end

  scenario 'with submitter, date, and link to the URL' do
    article = create(:article, created_at: 3.days.ago)

    visit root_path

    within('div') do
      expect(page).to have_link article.title, href: article.url
      expect(page).to have_content "by #{article.user.email} 3 days ago"
    end
  end
end
