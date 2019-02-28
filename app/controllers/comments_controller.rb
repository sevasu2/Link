class CommentsController < ApplicationController

  def create
  	comment = Comment.new(comment_params)
  	if comment.save
  	   redirect_to comment.entry, notice: 'コメントを投稿しました。'
  	else
  		redirect_back fallback_location: comment.entry
  	end
  end

  def destroy
  	comment = Comment.find(params[:id])
  	comment.delete
  	redirect_to comment.entry, notice: "コメントが削除されました"
  end

  private

  def comment_params
    params.require(:comment).permit(
      :board_id,
      :comment
      )
  end
end


