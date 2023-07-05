class CommentsController < ApplicationController
    
    def index
        # binding.pry
        @comments = Comment.all
        @comment = Comment.new
    end

    # def new
    #     @comment = Comment.new
    # end

    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            flash[:notice] = 'Comment created successfully. '
            redirect_to comments_path, notice: 'Comment created successfully.'
        else
            render :new 
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
