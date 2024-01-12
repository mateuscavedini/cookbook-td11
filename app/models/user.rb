class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes
  enum role: { user: 0, admin: 5 }

  has_many :received_follows, class_name: 'Follow', foreign_key: :followed_user_id
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, class_name: 'Follow', foreign_key: :follower_id
  has_many :followings, through: :given_follows, source: :followed_user
end
