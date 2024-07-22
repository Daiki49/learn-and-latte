class ShopsController < ApplicationController
  def index
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
