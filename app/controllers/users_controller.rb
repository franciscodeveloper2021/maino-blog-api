class UsersController < ApplicationController
  def initialize
    super
    @user_repository = UserModule::UserRepository.new

    @create_user_service = UseCases::UserActions::CreateUserService.new(@user_repository)
    @update_user_service = UseCases::UserActions::UpdateUserService.new(@user_repository)

    @login_authentication_service = UseCases::Authentication::LoginAuthenticationService.new(@user_repository)
  end

  def create
    user = @create_user_service.create(user_params)

    render json: user, except: [:password], status: :created
  end

  def log_in
    result = @login_authentication_service.perform(params[:email], params[:password])

    if result[:token]
      render json: result
    else
      render json: result, status: :unauthorized
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
