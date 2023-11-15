class User < ApplicationRecord
  before_validation :set_default_posts_counter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def set_default_posts_counter
    self.posts_counter ||= 0
  end
end
