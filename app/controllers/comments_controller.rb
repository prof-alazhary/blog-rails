class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  # def index
  #   @user = User.find params[:user_id]
  #   @post = @user.posts.find params[:post_id]
  #   @comments = @post.comments
  #   # @comments = Comment.all
  # end

  # GET /comments/1
  # GET /comments/1.json
  # def show
  #
  # end

  # GET /comments/new
  def new
    @user = User.find params[:user_id]
    @post = @user.posts.find params[:post_id]
    @comments = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @user = User.find params[:user_id]
    @post = @user.posts.find params[:post_id]
    @comments = @post.comments.new(comment_params)
    @comments.user_id=@post.user_id #dumy data ..user_id shoud be comming from session as 'current_user'
    respond_to do |format|
      if @comments.save
        format.html { redirect_to user_post_path({user_id: @user.id,id: @post.id}), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comments.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comments.update(comment_params)
        format.html { redirect_to user_post_comment_path([@user,@post,@comments]), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comments.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comments.destroy
    respond_to do |format|
      format.html { redirect_to user_post_comments_path([@user,@post,@comments]), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @user = User.find params[:user_id]
      @post = @user.posts.find params[:post_id]
      @comments = @post.comments.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :post_id, :user_id)
    end
end
