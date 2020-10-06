class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower

  # ユーザーをフォローする
  def follow(user)
    follower.create(followed_id: user.id)
  end
  # ユーザーのフォローを外す
  def unfollow(user)
    follower.find_by(followed_id: user.id).destroy
  end
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  #refile用
  attachment :profile_image

  #バリデーション
  #名前空out,2-20letters
  #intro 50letters max
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  #検索(前半、後半などの条件分岐)
  #selfはこのモデル（今はuser）が対象だよ、という意味
  #viewで入力したsearchとwordがsearch_controllerに行き、値をとってから、このmodelに
  def self.search(search, word)
    @user = User.all
    if search == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "match"
      @user = User.where("#{word}")
    elsif search == "partical"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
