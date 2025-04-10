class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_shops, through: :bookmarks, source: :shop
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  # 同じuidが異なるproviderで存在することは許容するが、同じprovider内で重複することは許容しないように設定
  # Googleを使った登録ではなく通常登録ではuidの一意性チェックによるバリデーションエラーを発生させないため、
  # provider がある場合のみ uid の一意性チェックを行うように設定
  validates :uid, uniqueness: { scope: :provider }, allow_nil: true

  def self.from_omniauth(auth)
    # OmniAuthによって取得されたユーザーの認証情報を持つユーザーを検索
    # 該当するユーザーが見つかればそれを返し、見つからなければ新しいユーザーを作成
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      # user.avatar = auth.info.image
    end
  end

  def own?(object)
    id == object&.user_id
  end

  def bookmark(shop)
    bookmark_shops << shop
  end

  def unbookmark(shop)
    bookmark_shops.destroy(shop)
  end

  def bookmark?(shop)
    bookmark_shops.include?(shop)
  end

  def like(post)
    like_posts << post
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)
    like_posts.include?(post)
  end
end
