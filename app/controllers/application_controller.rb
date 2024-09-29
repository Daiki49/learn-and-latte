class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 新規登録時に送信できる追加のパラメータを設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
