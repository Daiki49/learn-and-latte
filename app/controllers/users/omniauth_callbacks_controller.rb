# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # 通常、Railsではクロスサイトリクエストフォージェリ（CSRF）保護が有効
  # しかし、Google OAuth 2.0のリクエストは外部から送られてくるため、CSRFトークンの検証は不要
  # そのため、google_oauth2アクションに限って、CSRFトークンの検証をスキップ
  # skip_before_action :verify_authenticity_token, only: :google_oauth2

  def google_oauth2

    # 返却される認証情報を利用して、ユーザーをデータベースに保存
    # もしくはすでに存在するユーザーであればそのユーザーを取得
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      # 正常に保存され、データベースに存在する場合
      # ユーザーをログインさせる
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      # 正常に保存されなかった場合
      # セッションにomniauth.authのデータを一時的に保存
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    # 認証が失敗した場合
    redirect_to root_path, alert: "Authentication failed, please try again."
  end

  private

  def auth
    # 返却された認証情報を取得
    auth = request.env['omniauth.auth']
  end
  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
