# Concerns! Avoids code duplication in models that share functionality.
# http://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def voted_by?(user, direction)
    votes.find_by(user_id: user.id, direction: direction).present?
  end
end
