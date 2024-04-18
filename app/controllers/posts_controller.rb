class PostsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    per_page = 3
    page = params.fetch(:page, 1).to_i
    offset = (page - 1) * per_page
    posts = Post.order(created_at: :desc).limit(per_page).offset(offset)

    serialized_posts = posts.map do |post|
      post_attributes = post.attributes
      post_attributes[:comments] = post.comments.map(&:attributes)
      post_attributes
    end
    render json: serialized_posts, status: :ok
  end

  def show
    post = Post.find(params[:id])

    render json: post.slice(:id, :title, :body), status: :ok
  end

  def create
    post = Post.new(post_params)
    raise RuntimeError if !post.valid?

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless post.user_id == current_user.id

    post.save

    render json: post, status: :created
  end

  def update
    post = Post.find_by_id(params[:id])
    return render json: { error: 'Post not found' }, status: :not_found unless post

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless post.user_id == current_user.id

    if post.update(post_params)
      render json: post.slice(:id, :title, :body), status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find_by_id(params[:id])
    return render json: { error: 'Post not found' }, status: :not_found unless post

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless post.user_id == current_user.id

    post.destroy

    render json: { success: "Destroyed"}, status: :ok
  end

  private

  def set_post
    post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Token missing' }, status: :unauthorized unless token

    decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
    user_id = decoded_token.first['user_id']
    @current_user = User.find_by(id: user_id)

    render json: { error: 'Invalid token' }, status: :unauthorized unless @current_user
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end

  def current_user
    @current_user
  end
end
