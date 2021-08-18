module Administrator
  class EventsDataController < ApplicationController
    before_action :admin_user
    def index
      @events = Event.includes(user: :profile)
      @events_yesterday = Event.yesterday
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: 'event', template: 'administrator/events_data/index.html.haml'
        end
      end
    end

    private

    def admin_user
      redirect_to(root_url) unless current_user.administrator?
    end
  end
end
