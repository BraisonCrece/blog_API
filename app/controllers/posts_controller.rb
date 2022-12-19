class PostsController < ApplicationController
  # when create an action that can modify the request behavior, 
  # by convention we use the "!" at the end of the name
  before_action :authenticate_user!, only: [:create, :update]
  
  rescue_from Exception do |e|
    logger.error "error: #{e.message}"
    render json: { error: e.message }, status: :internal_error
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @posts = Post.where(published: true)
    if !params[:search].nil? && params[:search].present?
      @posts = PostSearchService.search(@posts, params[:search]) 
    end
    render json: @posts, status: :ok
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, status: :ok
  end

  def create
    @post = Post.create!(create_params)
    render json: @post, status: :created
  end

  def update
    @post = Post.find(params[:id])
    @post.update!(update_params)
    render json: @post, status: :ok
  end

  private

  def create_params
    params.require(:post).permit(:title, :content, :published, :user_id)
  end

  def update_params
    params.require(:post).permit(:title, :content, :published)
  end

  def authenticate_user!
    # read auth HEADER
    # validate auth token
    # validate that the token correspond with an user
    token_regex = /Bearer (\w+)/
    headers = request.headers
    if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
      token = headers['Authorization'].match(token_regex)[1]
      if (Current.user = User.find_by_auth_token(token))
        return
      end
    end
    render json: {error: 'Unauthorized'}, status: :unauthorized
  end
  
end