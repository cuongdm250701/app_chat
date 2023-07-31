class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET
  def index
    if current_user.role == 'admin'
      @q = Group.ransack(params[:q])
      @groups = @q.result().page(params[:page]).per(5)
    else
      @q = current_user.groups.ransack(params[:q])
      @groups = @q.result().page(params[:page]).per(5)
    end
  end
  # CREATE
  def new
    @group = Group.new
    1.times { @group.users.build }
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: "Group was successfully created."
    else
      redirect_to new_group_path, notice: "Error when create !"
    end
  end
  # UPDATE
  def edit
    @group = Group.find(params[:id])
    @users = User.where.not(role: :admin)
  end

  def update
    ActiveRecord::Base.transaction do
      if Group.check_amount_user params[:user_ids]
        @group = Group.find(params[:id])
        @group.users.destroy_all
        if @group.update(group_params)
          user_ids = params[:user_ids]
          @group.users << User.where(id: user_ids)
          redirect_to edit_group_path(params[:id]), notice: "Group was successfully update."
        else
          render :edit
        end
      else
        redirect_to edit_group_path(params[:id]), notice: "Group can not more than 5 user"
      end
    end
  end
  # DELETE
  def destroy
    
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: 'Group was successfully deleted.'
  end

  # ADD USER TO GROUP

  def add_users
    @q = User.ransack(params[:q])
    @group = Group.find(params[:id])
    @users = @q.result()
  end

  def add_members
    @group = Group.find(params[:id])
    user_ids = params[:user_ids]

    existing_users = @group.users.where(id: user_ids)
    new_user_ids = user_ids - existing_users.pluck(:id)

    new_users = User.where(id: new_user_ids)
    @group.users << new_users
    redirect_to groups_path, notice: "Users successfully added to the group."
  end

  # CHAT GROUP
  def show
    @group_id = params[:id]
    @group = Group.find(params[:id])
    @comments = @group.comments.order(created_at: :asc)
    @comment = Comment.new
  end

  def add_comments
    @group = Group.find(params[:id])
    @comment = @group.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast(
          "comment_#{params[:id]}",
          {
              send_by: current_user.username,
              content: @comment.content,
              content_user: "my-content"
          }
      )
      flash[:notice] = 'Comment created successfully. '
      # redirect_to group_path(@group.id), notice: 'Comment created successfully.'
    else
      render :new 
    end
  end


  private

  def group_params
    params.require(:group).permit(:name)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def group_params
    params.require(:group).permit(:name, users_attributes: [:id, :username, :email, :password, :password_confirmation, :_destroy])
  end
end
