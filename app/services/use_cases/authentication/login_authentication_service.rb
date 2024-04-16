module UseCases
  module Authentication
    class LoginAuthenticationService

      def initialize(user_repository)
        raise ArgumentError, I18n.t('errors.repository_required') if !user_repository
        @user_repository = user_repository
      end

      def perform(email, password)
        user = @user_repository.find_by_attribute(:email, email)

        if user && user.authenticate(password)
          token = JWT.encode({ user_id: user.id}, 'your_secret_key', 'HS256')
          { token: token }
        else
          { error: I18n.t('errors.invalid_email_or_password') }
        end
      end
    end
  end
end
