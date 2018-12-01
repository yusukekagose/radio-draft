module ApplicationHelper
  def avatar_url(user)
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    if user.image
      user.image
    else
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=40"
    end
  end

  def user_name
    username = current_user.name.nil? ? "anonymous#{User.last.id + 1}" : current_user.name
    return username
  end

  def truncate_user_name(speakers)
    speaker_names = ""
    speakers.each do |speaker|
      speaker_names << speaker.name + " "
    end
    speaker_names.truncate(28, omission: '...')
  end

  def return_radio_names
    radio_names = ""
    Radio.each do |item|
      radios << item.name
    end
    radio_names
  end

  def default_meta_tags
    {
      title:       "title",
      description: "description",
      keywords:    "ラジオ,下書き, #{return_radio_names}",#キーワードを「,」で区切る
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('sample.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      noindex: ! Rails.env.production?, # production環境以外はnoindex
      canonical: request.original_url,  # 優先されるurl
      charset: "UTF-8",
      # OGPの設定をしておくとfacebook, twitterなどの投稿を見た目よくしてくれます。
      # og: {
      #   title: :title,                #上のtitleと同じ値とするなら「:title」とする
      #   description: :description,　　#上のdescriptionと同じ値とするなら「:description」とする
      #   type: "website",
      #   url: request.original_url,
      #   image: image_url("sample_og.png"),
      #   site_name: "site name",
      #   locale: "ja_JP"
      # },
      # twitter: {
      #   site: '@ツイッターのアカウント名',
      #   card: 'summary',
      #   image: image_url("sample_twitter.png")　　　# ツイッター専用にイメージを設定する場合
      # },
      # fb: {
      #   app_id: '***************'    #ご自身のfacebookのapplication IDを設定
      # }
    }
  end
end
