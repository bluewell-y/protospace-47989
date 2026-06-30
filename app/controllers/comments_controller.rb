class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      # 保存ができた場合は、詳細ページにリダイレクトする
      redirect_to prototype_path(@comment.prototype)
    else
      # 保存ができなかった場合は、詳細ページに戻る
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
