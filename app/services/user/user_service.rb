# frozen_string_literal: true

module Services
  module User
    module UserService
      def create_user(data)
        user = ::User.new(data)

        errors, saved_user = Platform::Utils::DbUtils.save(user)

        raise CreateUserException.new('User not created', errors) if errors

        saved_user
      end

      def get_user(external_id)
        user = ::User.find_by(external_id: external_id)

        raise NotFoundException if user.nil?

        user
      end
    end
  end
end
