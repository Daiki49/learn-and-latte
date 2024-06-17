class StaticPagesController < ApplicationController
  def top
    @q = Post.ransack(params[:q])
  end
end
