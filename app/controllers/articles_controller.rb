class ArticlesController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc)
  end

  def new
    @article = current_user.articles.new
  end

  def create
    article = current_user.articles.new(article_params)
    article.save!
    redirect_to root_path, notice: 'Article submitted!'
  end

  private

  def article_params
    params.require(:article).permit(:title, :url)
  end
end
