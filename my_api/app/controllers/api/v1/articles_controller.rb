class Api::V1::ArticlesController < ApplicationController
  before_action :find_article_params, only: [:show, :update, :destroy]

  def index
    @articles = Article.all
    render json: @articles
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      result = { type: "Success", data: ActiveModelSerializers::SerializableResource.new(@article, each_serializer: ArticleSerializer), message: ["Article created successfully"], status: 200 }
      render json: result
    else
      render json: "Something went wrong"
    end
  end

  def show
    render json: @article
  end

  def update
    if @article.update(article_params)
      render json: @article, message: "Article Successfully Updated!!"
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    render json: "Article Successfully Deleted!!"
  end

  def article_title_search
    @article = Article.find_by(title: params[:title])
    if @article
      render json: @article
    else
      render json: "This type of article doesn't exist."
    end
  end

  private

  def find_article_params
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :release_date)
  end
end
