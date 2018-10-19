json.id Favorite.where(radio_id: @radio.id, user_id: current_user.id).ids.first if current_user
json.is_favorite Favorite.where(radio_id: @radio.id, user_id: current_user.id).present? if current_user
json.count @count
