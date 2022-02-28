class TodoController < ApplicationController

    include ActionController::HttpAuthentication::Token
  
    MAX_PAGINATION_LIMIT = 100

    before_action :authenticate_user

    rescue_from NoMethodError, with: :todo_does_not_exist

    def index
      todos = Todo.where(user_id: $user_id).limit(limit)

      render json: todos
    end

      
    private 
    
    def authenticate_user
      # Authorization: Bearer <token>
      token, _options = token_and_options(request)
      $user_id = AuthenticationTokenService.decode(token)
      User.find($user_id)
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render status: :unauthorized
    end
  
    def limit
      [
        params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
        MAX_PAGINATION_LIMIT
      ].min
    end
end
