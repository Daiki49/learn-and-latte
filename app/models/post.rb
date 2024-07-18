class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  attr_accessor :post_images_cache
  mount_uploaders :post_images, PostImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "power_availability", "quietness_level", "seat_comfort_level", "shop_id", "title", "updated_at", "user_id", "wifi_comfort_level"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["shop", "user"]
  end

  validates :quietness_level, :seat_comfort_level, :wifi_comfort_level, :power_availability, presence: true

  enum power_availability: { 電源が使える席があって使えた: 1, 電源が使える席がなくて使えなかった: 2, 特に電源を使う必要がなかった: 3 }
end
