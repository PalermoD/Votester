class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable
  

  default_scope -> {  order(:cached_votes_score => :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true 
  
end
