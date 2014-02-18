class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes, as: :votable

  validates :title, presence: true
  validates :url, url: true # Provided by "validate_url" gem

  def voted_by?(user, direction)
    votes.find_by(user_id: user.id, direction: direction).present?
  end
end
