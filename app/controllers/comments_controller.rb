class CommentsController < ApplicationController
  before_action :authenticate_user, only: :show
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    comments = Comment.all
    render json: comments, status: :ok
  end

  def show
    if @comment.user == current_user
      render json: @comment, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { success: "Destroyed"}, status: :ok
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
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
