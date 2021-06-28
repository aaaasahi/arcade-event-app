# frozen_string_literal: true

module UserDecorator
  
  def has_written?(event)
    events.exists?(id: event.id)
  end

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def display_name
    profile&.name || self.email.split('@').first
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'http://placehold.jp/eeeeee/cccccc/200x150.png?text=No%20Image'
    end
  end
end
