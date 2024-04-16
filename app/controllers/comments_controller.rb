class CommentsController < ApplicationController
  def create
    earthquake = Earthquake.find(params[:feature_id])
    comment = earthquake.comments.build(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end