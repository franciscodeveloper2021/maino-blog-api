class UsersController < ApplicationController

  def create
    create_user = UseCases::UserActions::CreateUserService.new(UserModule::UserRepository.new)
    user = create_user.create(user_params)

    render json: user, except: [:password], status: :created
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password)
  end
end
