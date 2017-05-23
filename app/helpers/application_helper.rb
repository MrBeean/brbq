module ApplicationHelper
  # Возвращает путь к аватарке данного юзера. Если у пользователя есть его
  # личная, возвращает её, иначе стандартную.
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('user.png')
    end
  end

  # Аналогично user_avatar, только возвращает миниатюрную версию
  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path('user.png')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
