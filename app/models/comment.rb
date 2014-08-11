class Comment < ActiveRecord::Base
  include Votable
  belongs_to :article, counter_cache: true
  belongs_to :user

  validates :body, presence: true
end
