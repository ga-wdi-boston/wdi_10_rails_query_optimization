class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end
end
