class AdminMailer < ApplicationMailer
  def report
    @users_registrant = User.count
    @users_registrant_yesterday = User.yesterday

    @events_post_count = Event.count
    @events_post_yesterday = Event.yesterday
    mail(to: Rails.application.credentials.gmail[:email], subject: '【定期連絡】集計結果')
  end
end
