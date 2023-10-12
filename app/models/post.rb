class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre

  has_one_attached :post_image

  # with_options presence: true, on: :publicize do
  #   validates :title, presence: true
  #   validates :body, presence: true
  # end
  validates :title, length: { maximum: 15 }, on: :publicize
  validates :body, length: { maximum: 80 }, on: :publicize

  # enum status: { published: 0, draft: 1,  unpublished: 2 }

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
end
