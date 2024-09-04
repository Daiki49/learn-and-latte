class ShopsController < ApplicationController

  before_action :set_google_maps_api_key

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def map
    @q = Shop.ransack(params[:q])
    @shops = Shop.all
    gon.shops = @shops.as_json
  end

  private

  def set_google_maps_api_key
    gon.google_maps_api_key = Rails.application.credentials.GOOGLE_MAPS_API_KEY
  end
end
