class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, url: true # Provided by "validate_url" gem
end
