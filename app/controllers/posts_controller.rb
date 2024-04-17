class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    per_page = 3
    page = params.fetch(:page, 1).to_i
    offset = (page - 1) * per_page
    @posts = Post.order(created_at: :desc).limit(per_page).offset(offset)

    render json: @posts, status: :ok
  end

  def show
    @post = Post.find(params[:id])

    render json: @post.slice(:id, :title, :body), status: :ok
  end

  def create
    post = Post.new(post_params)
    raise RuntimeError if !post.valid?

    post.save

    render json: post, status: :created
  end

  def update
    @post = Post.find_by_id(params[:id])
    return render json: { error: 'Post not found' }, status: :not_found unless @post

    if @post.attributes = post_params
      render json: @post.slice(:id, :title, :body), status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
