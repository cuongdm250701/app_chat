class PostsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        @group = Group.find(params[:group_id])
        @q = @group.posts.ransack(params[:q])
        @posts = @q.result().page(params[:page]).per(10)
    end

    def new
        @group = Group.find(params[:group_id])
        @post = @group.posts.new
    end

    def create
        @group = Group.find(params[:group_id])
        @post = @group.posts.new(post_params)
        if @post.save
            redirect_to group_posts_path(params[:group_id]), notice: "Post was successfully created."
        else
            render :new
        end
    end

    def edit
        @group = Group.find(params[:group_id])
        @post = @group.posts.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to  group_posts_path(params[:group_id]), notice: "Post was successfully update."\
        else
            render :edit
        end
    end

    def show
        @post = Post.find(params[:id])
        @comment_posts = @post.comment_posts.order(created_at: :asc)
        @comment_post = CommentPost.new
        respond_to do |format|
            format.html
            format.xlsx do
                render xlsx: 'Comments', template: 'posts/whatever'
            end
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to group_posts_path(params[:group_id]), notice: 'Post was successfully deleted.'
    end

    def add_comments
        @post = Post.find(params[:id])
        @comment_post = @post.comment_posts.build(comment_params)
        @comment_post.user = current_user
        if @comment_post.save
            redirect_to group_post_path(params[:group_id], params[:id]), notice: 'Comment was successfully.'
        else
            redirect_to group_post_path(params[:group_id], params[:id]), notice: 'Create comment error.'
        end
    end


    private

    def comment_params
        params.require(:comment_post).permit(:content)
    end

    def post_params
        params.require(:post).permit(:title, :description)
    end
end
