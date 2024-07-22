class Shop < ApplicationRecord
    has_many :posts, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["name", "address"]
    end
    def self.ransackable_associations(auth_object = nil)
        ["shop"]
    end
    validates :name, :address, presence: true
end
