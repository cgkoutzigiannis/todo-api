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

    private

    def parameter_missing(e)
        render json: { error: e.message }, status: :unprocessable_entity
    end

    def user_exists(e)
        render json: { error: e.message }, status: :conflict
    end
end
