class Shop < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    belongs_to :user
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

    def average_score_for(column)
        unless self.posts.empty?
            posts.average(column).round(1)
        else
            0.0
        end
    end

    def average_score_percentage_for(column)
        unless self.posts.empty?
            posts.average(column).round(1).to_f * 100 / 5
        else
            0.0
        end
    end

    # power_availabilityの各選択肢ごとの割合を計算するメソッド
    def power_availability_percentage_for(column)
        total_posts = posts.count.to_f
        return {} if total_posts.zero?

        percentages = {}
        Post.send(column.to_s.pluralize).keys.each do |key|
        count = posts.where(column => key).count
        percentages[key] = (count / total_posts * 100).round(1)
        end
        percentages
    end
end
