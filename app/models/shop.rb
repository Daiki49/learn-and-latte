class Shop < ApplicationRecord
    has_many :posts, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["name", "address"]
    end
    def self.ransackable_associations(auth_object = nil)
        ["shop"]
    end
    validates :name, :address, presence: true

    # addressカラムを使って緯度・経度を取得
    geocoded_by :address
    # addressが変更されたときに緯度・経度を更新
    after_validation :geocode, if: :address_changed?
    # 位置情報を扱うためのメソッドを追加
    acts_as_mappable default_units: :kms,
                    lat_column_name: :latitude,
                    lng_column_name: :longitude
end
