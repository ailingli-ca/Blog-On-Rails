class CommentsController < ApplicationController
    before_action :find_post
    before_action :authenticate_user!

    def create
        @comment = Comment.new(params.require(:comment).permit(:body)) 
        @comment.post = @post 
        @comment.user = current_user
        if @comment.save
          redirect_to post_path(@post), notice: "Comment created!"
        else
          @comments = @post.comments.order(created_at: :desc)
          render '/posts/show', status: 303
        end       
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post), notice: "Comment deleted successfully!"
    end

    private

    def find_post
        @post = Post.find params[:post_id]
    end
end
