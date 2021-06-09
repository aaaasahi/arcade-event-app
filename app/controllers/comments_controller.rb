class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    event = Event.find(params[:event_id])
    @comment = event.comments.build
    @comment.user = current_user
  end

  def create
    event = Event.find(params[:event_id])
    @comment = event.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to event_path(event), notice: 'コメントを追加'
    else
      flash.now[:error] = 'コメント出来ませんでした'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end