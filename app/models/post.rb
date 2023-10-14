class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre

  has_one_attached :post_image

  validates :title, length: { maximum: 15 }, on: :publicize, presence: true
  validates :body, length: { maximum: 80 }, on: :publicize, presence: true

  def get_post_image
    (post_image.attached?) ? post_image : "no_image.png"
  end


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(keyword)
     if keyword
       where(["title LIKE ?", "%#{keyword}%"])
     else
       all
     end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
