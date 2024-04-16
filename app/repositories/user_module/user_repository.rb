module UserModule
  class UserRepository

    def create(params)
      user = User.new(params)
      raise RuntimeError, I18n.t('errors.user_creation', errors: user.errors.full_messages) if !user.valid?

      user.save
      user
    end

    def update(current_user_id, params)
      user = User.find_by_id(current_user_id)
      raise RuntimeError, I18n.t('errors.user_not_found', id: current_user_id) if user.nil?

      user.attributes = params

      raise RuntimeError, I18n.t('errors.user_update', errors: user.errors.full_messages) if !user.valid?

      user.save
      user
    end
  end
end
