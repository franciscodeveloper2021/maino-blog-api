class UsersController < ApplicationController

  def create
    create_user = UseCases::UserActions::CreateUserService.new(UserModule::UserRepository.new)
    create_user.create(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password_digest, :password_digest_confirmation)
  end
end
