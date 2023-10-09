class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre

  has_one_attached :post_image

  validates :title, presence: true
  validates :body, presence: true

  def get_post_image
    (post_image.attached?) ? post_image : "no_image.png"
  end


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(search)
     if search
       where(["title LIKE ?", "%#{search}%"])
     else
       all
     end
  end
end
