class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @user = User.find params[:user_id]
    @posts = @user.posts
    # @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find params[:user_id]
    @post = @user.posts.find params[:id]
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @user = User.find params[:user_id]
    @post = @user.posts.new
  end

  # GET /posts/1/edit
  def edit
    @user = User.find params[:user_id]
    @post = Post.find params[:id]
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = User.find params[:user_id]
    @post = @user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    # @user = User.find params[:user_id]
    @post = Post.find params[:id]
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    # @user = User.find params[:user_id]
    @post = Post.find params[:id]
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:titel, :content, :user_id)
    end
end
