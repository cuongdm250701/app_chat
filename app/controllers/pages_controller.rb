class PagesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        @q = Page.ransack(params[:q])
        @pages = @q.result().page(params[:page]).per(10)
    end

    def new
        @page = Page.new
    end

    def create
        @page = Page.new(page_params)
        if @page.save
            redirect_to pages_path, notice: "Page was successfully created."
        else
            redirect_to new_page_path, notice: "Error when create !"
        end
    end

    def edit
        @page = Page.find(params[:id])
    end

    def update
        @page = Page.find(params[:id])
        if @page.update(page_params)
            redirect_to pages_path, notice: "Page was successfully updated."
        else
            redirect_to :edit
        end
    end


    def destroy
        @page = Page.find(params[:id])
        @page.destroy
        redirect_to pages_path, notice: 'Post was successfully deleted.'
    end

    def show
        @page = Page.find(params[:id])
        @comment_pages = @page.evaluates.order(created_at: :asc)
        @comment_page = Evaluate.new
        respond_to do |format|
            format.html
            format.xlsx do
                render xlsx: 'Comments', template: 'pages/whatever'
            end
        end
    end

    def add_comments
        @page = Page.find(params[:id])
        @comment_page = @page.evaluates.build(comment_params)
        @comment_page.user = current_user
        if @comment_page.save
            redirect_to page_path(params[:id]), notice: 'Comment was successfully.'
        else
            redirect_to page_path(params[:id]), notice: 'Create comment error.'
        end
    end


    private

    def page_params
        params.require(:page).permit(:title, :content)
    end

    def comment_params
        params.require(:evaluate).permit(:content)
    end
end
