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
  
 #検索(前半、後半などの条件分岐)
  def self.search(search, word)
    if search == "forward"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "match"
      @book = Book.where("#{word}")
    elsif search == "partical"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  
end
