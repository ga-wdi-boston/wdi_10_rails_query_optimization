require 'rails_helper'

feature 'Visitor views all articles on the home page' do
  scenario 'with score, submitter, date, and link to the URL' do
    article = create_article_with_votes(5, 3, created_at: 3.days.ago)

    visit root_path

    within('div') do
      expect(page).to have_link article.title, href: article.url
      expect(page).to have_content "2 points by #{article.user.email} 3 days ago"
    end
  end

  scenario 'ordered by highest score first' do
    okay_article = create_article_with_votes(5, 1) # 4 points
    cool_article = create_article_with_votes(10, 2) # 8 points
    lame_article = create_article_with_votes(1, 3) # -2 points

    visit root_path

    expect(page).to have_content(
      /#{cool_article.title}.*#{okay_article.title}.*#{lame_article.title}/
    )
  end

  def create_article_with_votes(upvotes, downvotes, **attributes)
    article = create(:article, attributes)
    create_list(:vote, upvotes, votable: article, direction: 'up')
    create_list(:vote, downvotes, votable: article, direction: 'down')
    article
  end
end
