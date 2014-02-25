module ApplicationHelper
  def vote_link(votable, direction)
    already_voted = votable.voted_by?(current_user, direction)
    new_direction = already_voted ? 'neutral' : direction
    path = polymorphic_path([votable, :vote], direction: new_direction)
    link = link_to "#{direction.capitalize}vote", path, method: :patch

    already_voted ? content_tag('b', link) : link
  end
end
