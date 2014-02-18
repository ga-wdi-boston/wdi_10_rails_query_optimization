class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :direction, inclusion: { in: ['up', 'down', 'neutral'] }

  # After any vote is successfully saved, call this method on it
  after_save :update_votable_score

  # Caching the score of a votable as a database column avoids a whole bunch
  # of N+1 issues, but it does mean we need to keep that "cache" up to date.
  def update_votable_score
    upvotes = votable.votes.where(direction: 'up').count
    downvotes = votable.votes.where(direction: 'down').count
    votable.update!(score: upvotes - downvotes)
  end
end
