crumb :root do
  link "TOP", root_path
end

crumb :user_login do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :user_signin do
  link "新規登録", new_user_registration_path
  parent :root
end

crumb :event_search do 
  link "イベント一覧", events_search_path
  parent :root
end

crumb :event_show do |event|
  link event.name, event_path(event)
  parent :event_search, event
end

crumb :user_profile do |user|
  link user.display_name
  parent :root
end

crumb :event_new do
  link "イベント作成", new_event_path
  parent :root
end

crumb :event_edit do |event|
  link "ユーザー編集"
  parent :event_show, event
end

crumb :event_calendar do
  link "イベントカレンダー", calendars_path
  parent :root
end

crumb :profile_top do |user|
  link user.display_name, profile_path
  parent :root
end

crumb :profile_clip do |user|
  link 'クリップ'
  parent :profile_top, user
end

crumb :profile_join do |user|
  link '参加予定'
  parent :profile_top, user
end

crumb :profile_message do |user|
  link 'メッセージ一覧',rooms_path
  parent :profile_top, user
end

crumb :message do |user|
  link 'メッセージ'
  parent :profile_message, user
end

crumb :profile_edit do |user|
  link 'プロフィール変更'
  parent :profile_top, user
end

crumb :profile_user_edit do |user|
  link 'ユーザー情報変更'
  parent :profile_top, user
end

crumb :profile_unsubscribe do |user|
  link '退会'
  parent :profile_top, user
end


