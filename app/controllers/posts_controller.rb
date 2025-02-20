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
    session[:previous_url] = request.referer  # 前ページセッションを保存
    @post.post_images.each { |image| image.cache! } unless @post.post_images.blank? # 画像キャッシュ
  end

  def update

    @post = current_user.posts.find(params[:id])

    # 現在の投稿に関連付けられている画像をexisting_imagesに保持
    existing_images = @post.post_images

    # post_paramsからshop_idとpost_imagesを除いた属性を@postに割り当て
    @post.assign_attributes(post_params.except(:shop_id, :post_images))

    # 新しい画像が送信されている場合、既存の画像に追加
    if post_params[:post_images].present?
      @post.post_images += post_params[:post_images]
    else
      @post.post_images = existing_images  # 画像が送信されていない場合は元の画像を保持
    end

    # 画像削除処理
    if params[:post][:remove_image_at].present?
      # 削除対象のインデックスをカンマ区切りで取得し、削除処理を行う
      params[:post][:remove_image_at].split(',').each do |index|
        index = index.to_i

        # インデックスが画像の数より小さい場合のみ削除処理を行う
        @post.remove_image_at_index(index) if index < @post.post_images.length
      end
    end

    # 更新処理
    if @post.save
      # flash[:success] = t('posts.update.success') # フラッシュメッセージ
      redirect_to session[:previous_url] || shop_post_path(@shop, @post), success: t('defaults.flash_message.updated', item: @post.model_name.human) # 前のページにリダイレクト
    else
      flash.now[:danger] = t('posts.update.failure') + @post.errors.full_messages.join(', ')
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
    params.require(:post).permit(:title, :rating, :quietness_level, :seat_comfort_level, :wifi_comfort_level, :power_availability, :body, { post_images: [] }, :post_images_cache)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

end
