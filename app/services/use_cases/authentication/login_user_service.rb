module UseCases
  module Authentication
    class LoginUserService

      def initialize(user_repository)
        raise ArgumentError, I18n.t('errors.repository_required') if !user_repository
        @user_repository = user_repository
      end

      def perform
        user = @user_repository.find_by_attribute(:email, params[:email])

        if user && user.authenticate(params[:password])
          token = JWT.encode({ user_id: user.id}, 'your_secret_key', 'HS256')
          render json: { token: token }
        else
          render json: { error: I18n.t('errors.invalid_email_or_password')}, status: :unauthorized
        end
      end
    end
  end
end