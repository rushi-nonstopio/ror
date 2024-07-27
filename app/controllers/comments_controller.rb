class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.name = current_user.email
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created'
    else
      redirect_to @post, alert: 'Error creating comment'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id]), notice: 'Comment was successfully destroyed'
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :text)
  end
end
