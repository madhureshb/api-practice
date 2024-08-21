class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render json: { article: @article, message: "Article created successfully", status: :created }
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found", status: :not_found }
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      render json: { article: @article, message: "Article successfully updated", status: :updated }
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found" }, status: :not_found
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    render json: { message: "Article deleted successfully", status: :deleted }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found", status: :not_found }
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
