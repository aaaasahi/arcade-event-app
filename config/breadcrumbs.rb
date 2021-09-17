crumb :root do
  link 'TOP', root_path
end

crumb :user_login do
  link I18n.t('auth.login'), new_user_session_path
  parent :root
end

crumb :user_signin do
  link I18n.t('auth.new'), new_user_registration_path
  parent :root
end

crumb :event_search do
  link I18n.t('events.search.event-list'), events_search_path
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
  link I18n.t('events.form.event-post'), new_event_path
  parent :root
end

crumb :event_edit do |event|
  link I18n.t('events.form.event-edit')
  parent :event_show, event
end

crumb :event_calendar do
  link I18n.t('events.calendar.event-calendar'), calendars_path
  parent :root
end

crumb :notice do
  link I18n.t('notice.title'), notifications_path
  parent :root
end

crumb :profile_top do |user|
  link user.display_name, profile_path
  parent :root
end

crumb :profile_clip do |user|
  link I18n.t('events.show.clip-list')
  parent :profile_top, user
end

crumb :profile_join do |user|
  link I18n.t('events.show.join-list')
  parent :profile_top, user
end

crumb :profile_message do |user|
  link I18n.t('profiles.message-index'), rooms_path
  parent :profile_top, user
end

crumb :message do |user|
  link I18n.t('profiles.link.message')
  parent :profile_message, user
end

crumb :profile_edit do |user|
  link I18n.t('profiles.link.change-profile')
  parent :profile_top, user
end

crumb :profile_user_edit do |user|
  link I18n.t('profiles.link.change-user')
  parent :profile_top, user
end

crumb :profile_unsubscribe do |user|
  link I18n.t('profiles.link.withdrawal')
  parent :profile_top, user
end

crumb :guide_post do
  link 'イベント主催ガイド', guide_posts_path
  parent :root
end

crumb :guide_search do
  link 'イベント検索ガイド', guide_search_index_path
  parent :root
end
