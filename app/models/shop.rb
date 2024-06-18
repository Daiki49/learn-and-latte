class Shop < ApplicationRecord
    has_many :posts, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "id", "id_value", "latitude", "longitude", "name", "opening_hours", "phone_number", "place_id", "updated_at"]
    end
    validates :name, :address, presence: true
end
