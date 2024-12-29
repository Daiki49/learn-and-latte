class BookmarksController < ApplicationController

  # 指定のアクションに対して認証を要求
  before_action :authenticate_user!, only: [:create]

  def create
    @shop = Shop.find(params[:shop_id])
    current_user.bookmark(@shop)
  end

  def destroy
    @shop = current_user.bookmarks.find(params[:id]).shop
    current_user.unbookmark(@shop)
  end
end
