class Api::V1::ArticleCommentsController < ApplicationController
  before_action :find_comment_params, only: [:show, :update, :destroy]

  def index
    @comments = ArticleComment.all
    render json: @comments
  end

  def create
    @comment = ArticleComment.new(comment_params)
    if @comment.save
      result = { type: "Success", data: ActiveModelSerializers::SerializableResource.new(@comment, each_serializer: ArticleCommentSerializer), message: ["ArticleComment created successfully"], status: 200 }
      render json: result
    else
      render json: "Something went wrong"
    end
  end

  def show
    render json: @comment
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, message: "Comment Successfully Updated!!"
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: "ArticleComment Successfully Deleted!!"
  end

  def comment_search
    @comment = ArticleComment.find_by(comment: params[:comment])
    if @comment
      render json: @comment
    else
      render json: "This type of comment doesn't exist."
    end
  end

  private

  def find_comment_params
    @comment = ArticleComment.find(params[:id])
  end

  def comment_params
    params.require(:article_comment).permit(:comment, :date_of_comment, :article_id)
  end
end
