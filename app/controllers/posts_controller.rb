class PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @shop = Shop.new
  end

  def create
    ActiveRecord::Base.transaction do
      @shop = Shop.find_or_create_by(name: shop_params[:shop_name], address: shop_params[:shop_address])
      if @shop.save
        @post = User.find(1).posts.build(post_params.merge(shop_id: @shop.id))
        if @post.save
          redirect_to posts_path, success: t('posts.create.success')
        else
          flash.now[:danger] = t('posts.create.failure') + @post.errors.full_messages.join(', ')
          render :new, status: :unprocessable_entity
          raise ActiveRecord::Rollback
        end
      else
        @post = User.find(1).posts.build(post_params.merge(shop_id: @shop.id))
        @post.valid?
        flash.now[:danger] = t('posts.create.failure') + @post.errors.full_messages.join(', ')
        render :new, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def shop_params
    params.require(:post).permit(:shop_name, :shop_address)
  end

  def post_params
    params.require(:post).permit(:title, :quietness_level, :seat_comfort_level, :wifi_comfort_level, :power_availability, :body)
  end
end
