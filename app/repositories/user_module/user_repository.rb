module UserModule
  class UserRepository
    def create(params)
      User.create(params)
    end
  end
end
