class AuthController < ApplicationController
    class AuthenticationError < StandardError; end

    rescue_from AuthenticationError, NoMethodError, with: :handle_unauthenticated
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from ActiveRecord::RecordNotUnique, with: :user_exists

    def signup
        user = User.new(username: params.require(:username))

        user.password = params.require(:password)

        if user.save
            render json: user, status: :created
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end

    def login
        key = SecureRandom.hex
        raise AuthenticationError unless user.authenticate(params.require(:password), key)
        token = AuthenticationTokenService.call(user.id)

        render json: {token: token}, status: :created
    end

    def logout
    end

    private

    def user
        @user ||= User.find_by(username: params.require(:username)) # Memorized value "||="
    rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
    end

    def handle_unauthenticated(e)
        render json: { error: e.message }, status: :unauthorized
    end

    def parameter_missing(e)
        render json: { error: e.message }, status: :unprocessable_entity
    end

    def user_exists(e)
        render json: { error: e.message }, status: :conflict
    end
end
