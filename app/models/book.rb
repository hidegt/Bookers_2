class Book < ApplicationRecord
  belongs_to :user
  
  #バリデーション
  #title,body空out,-200letters
  validates :title, presence: true
  validates :body, length: { maximum: 200 }, presence: true
  
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  has_many :book_comments, dependent: :destroy
  
end
