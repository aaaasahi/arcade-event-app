namespace :admin_report do
  desc '管理者に総登録者数とイベント投稿数、昨日登録したユーザー数、ユーザー名とイベント投稿数、タイトル、投稿者をメールで送信'
  task mail_admin_report: :environment do
    AdminMailer.report.deliver_now
  end
end
