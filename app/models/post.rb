class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  has_many :likes, dependent: :destroy
  validates :post_images, presence: true
  mount_uploaders :post_images, PostImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "ratign", "power_availability", "quietness_level", "seat_comfort_level", "shop_id", "title", "updated_at", "user_id", "wifi_comfort_level"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["shop", "user"]
  end

  # 画像削除を処理するメソッド
  def remove_image_at_index(index)
    remain_images = self.post_images # 現在の画像を複製
    remain_images.delete_at(index)
    self.post_images = remain_images
  end

  validates :quietness_level, :seat_comfort_level, :wifi_comfort_level, :power_availability, :rating, presence: true

  enum power_availability: { 電源が使える席があって使えた: 1, 電源が使える席がなくて使えなかった: 2, 特に電源を使う必要がなかった: 3 }
end
