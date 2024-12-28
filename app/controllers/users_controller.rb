class UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.includes(:user).order(created_at: :desc) # ユーザーの投稿を取得
    @no_results = @posts.empty? # 投稿がないかどうかを判断
    # @bookmark_shops = current_user.bookmark_shops.includes(:user).order(created_at: :desc)
  end

  # def profile
  #   @user = current_user
  #   render partial: 'profile'
  # end

  # def my_posts
  #   @user = current_user # 現在のユーザーを取得
  #   @posts = @user.posts.includes(:user).order(created_at: :desc) # ユーザーの投稿を取得
  #   @no_results = @posts.empty? # 投稿がないかどうかを判断

  #   # @postsの内容をログに出力
  #   Rails.logger.info "User posts: #{@posts.inspect}"

  #   render partial: 'my_posts'
  # end
  def likes
    @user = current_user
    @like_posts = @user.like_posts.includes(:user).order(created_at: :desc)
  end
end
