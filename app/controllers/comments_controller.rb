class CommentsController < ApplicationController
    before_action :authenticate_user!

    def index
        # binding.pry
        @comments = Comment.includes(:user).all
        @comment = Comment.new
    end

    # def new
    #     @comment = Comment.new
    # end

    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            content_user = @comment.user_id == current_user.id ? 'my-content' : 'other-content'
            ActionCable.server.broadcast(
                'comment',
                {
                    send_by: current_user.username,
                    content: @comment.content,
                    content_user: content_user
                }
            )
            flash[:notice] = 'Comment created successfully. '
            # redirect_to comments_path, notice: 'Comment created successfully.'
        else
            render :new 
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
