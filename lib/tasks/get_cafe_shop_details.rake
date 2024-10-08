require 'csv' #csvファイルを操作するライブラリの読み込み
require 'open-uri' #open-uriライブラリを読み込んでいる
API_KEY = Rails.application.credentials.GOOGLE_MAPS_API_KEY #APIキーを代入

namespace :Cafe do
  desc 'Fetch and save shop details'
  task :get_and_save_details => :environment do
    #電話番号からplace_idを取得するメソッド
    def get_place_id(phone_number)
      client = GooglePlaces::Client.new(API_KEY)
      spot = client.spots_by_query(phone_number).first
      spot.place_id if spot
    end

    #place_idから詳細情報を取得するメソッド
    def get_detail_data(shop)
      place_id = get_place_id(shop['電話番号'])

      if place_id
        # データベース内を検索
        existing_shop = Shop.find_by(place_id: place_id)
        if existing_shop
          puts "既に保存済みです: #{shop['店名']}"
          return nil
        end

        #クエリーパラメータの作成
        place_detail_query = URI.encode_www_form(
          place_id: place_id,
          language: 'ja',
          key: API_KEY
        )
        #PlacesAPIのエンドポイントの作成
        place_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?#{place_detail_query}"
        #APIから取得したデータをテキストデータ（JSON形式）で取得し、変数に格納
        place_detail_page = URI.open(place_detail_url).read
        #JSON形式のデータを、Rubyオブジェクトに変換
        place_detail_data = JSON.parse(place_detail_page)

        #取得したデータを保存するカラム名と同じキー名で、ハッシュ（result）に保存
        result = {}
        result[:name] = shop['店名']
        # result[:postal_code] = place_detail_data['result']['address_components'].find { |c| c['types'].include?('postal_code') }&.fetch('long_name', nil)

        full_address = place_detail_data['result']['formatted_address']
        result[:address] = full_address.sub(/\A[^ ]+/, '')

        result[:phone_number] = place_detail_data['result']['formatted_phone_number']
        result[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'].join("\n") if place_detail_data['result']['opening_hours'].present?
        # result[:web_site] = place_details_data['result']['website']
        result[:latitude] = place_detail_data['result']['geometry']['location']['lat']
        result[:longitude] = place_detail_data['result']['geometry']['location']['lng']
        result[:place_id] = place_id
        # result[:web_site] = place_detail_data['result']['website']

        result
      else
        puts "詳細情報が見つかりませんでした。"
        nil
      end
    end

    #csvファイルを読み込む
    csv_file = 'lib/cafe.csv'
    #csvファイルの繰り返し処理で実行しデータベースへ保存
    CSV.foreach(csv_file, headers: true) do |row|
      shop_data = get_detail_data(row)
      if shop_data
        shop = Shop.create!(shop_data)
        puts "#{row['店名']}を保存しました"
        puts "----------"
      else
        puts "#{row['店名']}の保存に失敗しました"
      end
    end
  end
end
