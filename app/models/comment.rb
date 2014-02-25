class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :votes, as: :votable

  validates :body, presence: true

  def voted_by?(user, direction)
    votes.find_by(user_id: user.id, direction: direction).present?
  end
end
