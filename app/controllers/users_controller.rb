class UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.includes(:user).order(created_at: :desc) # ユーザーの投稿を取得
    @no_results = @posts.empty? # 投稿がないかどうかを判断
    @like_posts = @user.like_posts.includes(:user).order(created_at: :desc)
  end
end
