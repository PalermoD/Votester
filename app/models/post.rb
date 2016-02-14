class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments
  acts_as_votable
  acts_as_commontable

  default_scope -> {  order(:cached_votes_up => :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true 
  validates :content, presence: true, length: { maximum: 140 }
end
