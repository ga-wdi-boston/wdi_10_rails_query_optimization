class Article < ActiveRecord::Base
  include Votable
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :url, url: true # Provided by "validate_url" gem
end
