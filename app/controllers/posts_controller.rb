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

    render json: @post, status: :ok
  end

  def create
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
