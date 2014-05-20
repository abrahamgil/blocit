class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    # @comment = Comment.new(comment_params)
    # @comment.user = current_user
    # 3 and 4 are the same as line 7
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize @comment
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment was saved successfully."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@topic, @post]
    end

  end
  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end