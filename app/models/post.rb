class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "power_availability", "quietness_level", "seat_comfort_level", "shop_id", "title", "updated_at", "user_id", "wifi_comfort_level"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["shop", "user"]
  end
end
