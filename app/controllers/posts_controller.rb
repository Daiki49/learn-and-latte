class PostsController < ApplicationController

  # 指定のアクションに対して認証を要求
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_shop, only: [:new, :create]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params.merge(shop_id: @shop.id))
    if @post.save
      redirect_to shop_path(@shop), success: t('posts.create.success')
    else
      # 保存に失敗した場合の処理
      flash.now[:danger] = t('posts.create.failure') + @post.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :rating, :quietness_level, :seat_comfort_level, :wifi_comfort_level, :power_availability, :body, { post_images: [] })
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
