class PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @shop = Shop.find_by(id: params[:shop_id])
  end

  def create
    # フォームに含まれるpostオブジェクトの中のshop_idフィールドの値を取得し、Shopオブジェクトを検索
    @shop = Shop.find_by(id: params[:post][:shop_id])
    if @shop.nil?
      # shopが見つからない場合の処理
      flash[:error] = "レビュー対象のお店が見つかりません。"
      render :new, status: :unprocessable_entity
      return
    end
    @post = User.find_by(id: 1).posts.build(post_params.merge(shop_id: @shop.id))
    if @post.save
      redirect_to posts_path, success: t('posts.create.success')
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
end
