module NotificationDecorator
  def how_long_ago
    if (Time.zone.now - created_at) <= 60 * 60
      "#{((Time.zone.now - created_at) / 60).to_i}分前"
    elsif (Time.zone.now - created_at) <= 60 * 60 * 24
      "#{((Time.zone.now - created_at) / 3600).to_i}時間前"
    elsif (Date.today - created_at.to_date) <= 30
      "#{(Date.today - created_at.to_date).to_i}日前"
    else
      created_at
    end
  end
end
