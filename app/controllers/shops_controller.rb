class ShopsController < ApplicationController

  before_action :set_google_maps_api_key

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true)
  end

  def show
    @shop = Shop.find(params[:id])
    @posts = @shop.posts.includes(:user).order(created_at: :desc)
  end

  def map
    # パラメータから緯度・経度を取得
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    origin = [latitude, longitude]
    # 半径10km以内のカフェを検索
    @shops = Shop.all.within(10, origin: [latitude, longitude])
    # カフェの情報をJavaScriptに渡す
    gon.shops = @shops.as_json
    # リクエストがHTMLかJSONかをチェック
    respond_to do |format|
      format.html # HTMLの場合は通常のビューを表示
      format.json { render json: { shops: @shops.as_json } } # JSON形式の場合はデータを返す
    end
  end

  private

  def set_google_maps_api_key
    gon.google_maps_api_key = Rails.application.credentials.GOOGLE_MAPS_API_KEY
  end
end
