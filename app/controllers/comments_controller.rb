class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    @comment = event.comments.build(comment_params)
    if @comment.save
      redirect_to event_path(event), notice: 'コメントを追加'
    else
      flash.now[:error] = 'コメント出来ませんでした'
      redirect_to event_path(event)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, event_id: params[:event_id])
  end
end
