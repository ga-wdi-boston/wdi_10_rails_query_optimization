module ApplicationHelper
  def vote_link(article, direction)
    voted = article.voted_by?(current_user, direction)
    path = article_vote_path(article, direction: voted ? 'neutral' : direction)
    link = link_to "#{direction.capitalize}vote", path, method: :patch

    voted ? content_tag('b', link) : link
  end
end
