module ApplicationHelper
  # OGP用のメタタグを設定
  def prepare_meta_tags(resource)
    if resource.is_a?(Post)
      shop_name = resource.shop.name
      title_text = "「#{shop_name}」\nカフェ勉強レビューをシェア!"
    elsif resource.is_a?(Shop)
      shop_name = resource.name
      title_text = "「#{shop_name}」\nカフェをシェア!"
    else
      return # resource がどちらでもない場合は処理しない
    end

    image_url = "#{request.base_url}/images/ogp_image.png?text=#{CGI.escape(title_text)}"

    set_meta_tags og: {
                    site_name: 'Learn&Latte',
                    title: 'Learn&Latte',
                    description: title_text,
                    type: 'website',
                    url: request.original_url,
                    image: image_url,
                    locale: 'ja-JP'
                  },
                  twitter: {
                    card: 'summary_large_image',
                    site: '',
                    image: image_url
                  }
  end
end
