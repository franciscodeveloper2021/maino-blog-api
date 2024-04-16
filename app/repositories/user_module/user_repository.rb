module UserModule
  class UserRepository

    def create(params)
      user = User.new(params)
      return raise RuntimeError, I18n.t('errors.user_creation', errors: user.errors.full_messages) if !user.valid?

      user.save
    end

  end
end
