class Book < ApplicationRecord
  belongs_to :user
  
  #バリデーション
  #title,body空out,-200letters
  validates :title, presence: true
  validates :body, length: { maximum: 200 }, presence: true
end
