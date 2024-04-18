require "jwt"

class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :update]

  def initialize
    super
    @user_repository = UserModule::UserRepository.new

    @create_user_service = UseCases::UserActions::CreateUserService.new(@user_repository)
    @update_user_service = UseCases::UserActions::UpdateUserService.new(@user_repository)

    @login_authentication_service = UseCases::Authentication::LoginAuthenticationService.new(@user_repository)
  end

  def welcome
    render plain: "Bem-vindo ao meu aplicativo"
  end

  def show
    user = @user_repository.find_by_id(params[:id])

    render json: user, except: [:password], status: :ok
  end

  def create
    user = @create_user_service.create(user_params)

    render json: user, except: [:password], status: :created
  end

  def update
    updated_user = @update_user_service.update(params[:id], user_params)

    render json: updated_user, except: [:password], status: :ok
  end

  def log_in
    result = @login_authentication_service.perform(params[:email], params[:password])

    if result[:token]
      render json: result
    else
      render json: result, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password)
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
end
