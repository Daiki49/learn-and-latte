class PostsController < ApplicationController

  # 指定のアクションに対して認証を要求
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_shop, only: [:new, :create, :edit, :update, :destroy]

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

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      # redirect_to shop_post_path(@shop, @post), success: t('defaults.flash_message.updated', item: post.model_name.human)
      # TODO: 下記を使った形式に変更する。
      # item: post.model_name.human
      redirect_to shop_post_path(@shop, @post), success: t('defaults.flash_message.updated')
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    # redirect_to posts_path, success: t('defaults.flash_message.deleted', item: post.model_name.human), status: :see_other
    # TODO: 下記を使った形式に変更する。
    # item: post.model_name.human
    redirect_to shop_posts_path, success: t('defaults.flash_message.deleted'), status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :rating, :quietness_level, :seat_comfort_level, :wifi_comfort_level, :power_availability, :body, { post_images: [] })
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
