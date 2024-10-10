class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :posts, dependent: :destroy

  # 同じuidが異なるproviderで存在することは許容するが、同じprovider内で重複することは許容しないように設定
  validates :uid, uniqueness: { scope: :provider }

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
end
