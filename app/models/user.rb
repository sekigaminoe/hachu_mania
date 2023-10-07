class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :post_comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #フォローする側
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #自分がフォローしてる人
  has_many :followings, through: :relationships, source: :followed

  #フォローされる側
  has_many :reverse_of_relationships, class_name: "Relationships", foreign_key: "followed_id", dependent: :destroy
  #自分をフォローしてる人
  has_many :followers, through: :reverse_of_relatiomships, source: :follower

  has_one_attached :plofile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
