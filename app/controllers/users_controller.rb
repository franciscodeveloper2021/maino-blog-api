require 'jwt'

class UsersController < ApplicationController
  def initialize
    super
    @user_repository = UserModule::UserRepository.new

    @create_user_service = UseCases::UserActions::CreateUserService.new(@user_repository)
    @update_user_service = UseCases::UserActions::UpdateUserService.new(@user_repository)
  end

  def create
    user = @create_user_service.create(user_params)

    render json: user, except: [:password], status: :created
  end

  def log_in
    user = @user_repository.find_by_attribute(:email, params[:email])

    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id}, 'your_secret_key', 'HS256')
      render json: { token: token }
    else
      render json: { error: I18n.t('errors.invalid_email_or_password')}, status: :unauthorized
    end
  end

  def update
    updated_user = @update_user_service.update(params[:id], user_params)

    render json: updated_user, except: [:password], status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password)
  end
end
