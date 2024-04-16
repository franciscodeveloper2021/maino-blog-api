module UserModule
  class UserRepository

    def create(params)
      user = User.new(params)
      raise RuntimeError, I18n.t('errors.user_creation', errors: user.errors.full_messages) if !user.valid?

      user.save
      user.attributes.except('password_digest')
    end
  end
end
