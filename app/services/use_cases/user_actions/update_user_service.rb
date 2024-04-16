module UseCases
  module UserActions
    class UpdateUserService

      def initialize(user_repository)
        raise ArgumentError, I18n.t('errors.repository_required') if !user_repository
        @user_repository = user_repository
      end

      def update(id, params)
        @user_repository.update(id, params)
      end
    end
  end
end
