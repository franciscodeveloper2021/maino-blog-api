module UseCases
  module UserActions
    class UpdatePasswordService

      def initialize(user_repository)
        raise ArgumentError, I18n.t('errors.repository_required') if !user_repository
        @user_repository = user_repository
      end

      def update(id, update_password)
        @user_repository.update_password(id, params)
      end
    end
  end
end
