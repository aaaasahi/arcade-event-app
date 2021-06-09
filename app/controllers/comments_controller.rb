class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end
end