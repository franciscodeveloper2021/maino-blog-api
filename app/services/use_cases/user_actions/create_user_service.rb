module UseCases
  module UserActions
    class CreateUserService

      def initialize(user_repository)
        raise ArgumentError, I18n.t('errors.repository_required') if !user_repository
        @user_repository = user_repository
      end

      def create(params)
        @user_repository.create(params)
      end
    end
  end
end
