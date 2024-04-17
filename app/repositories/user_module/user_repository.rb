module UserModule
  class UserRepository

    def create(params)
      user = User.new(params)
      raise RuntimeError, I18n.t('errors.user_creation', errors: user.errors.full_messages) unless user.valid?

      user.save
      user
    end

    def find_by_attribute(attribute, value)
      user = User.find_by(attribute => value)
      raise ActiveRecord::RecordNotFound if user.nil?
      user
    end

    def update(current_user_id, params)
      user = find_user_by_id(current_user_id)
      user.attributes = params

      raise RuntimeError, I18n.t('errors.user_update', errors: user.errors.full_messages) unless user.valid?

      user.save
      user
    end

    private

    def find_user_by_id(user_id)
      user = User.find_by_id(user_id)
      raise RuntimeError, I18n.t('errors.user_not_found', id: user_id) if user.nil?
      user
    end
  end
end
