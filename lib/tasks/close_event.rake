namespace :close_event do
  desc 'イベント開催日が過ぎたらイベントをcloseする'
  task close_event: :environment do
    Event.where('start_time < ?', Date.today).where(status: false).update_all(status: true)
  end
end
