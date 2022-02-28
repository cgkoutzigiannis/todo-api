class TodosController < ApplicationController

    include ActionController::HttpAuthentication::Token
  
    MAX_PAGINATION_LIMIT = 100

    before_action :authenticate_user

    rescue_from NoMethodError, with: :todo_does_not_exist

    def index
      todos = Todo.where(user_id: $user_id).limit(limit).offset(offset)

      render json: todos
    end

    def create
        todo = Todo.new(todo_params.merge(user_id: $user_id))
    
        if todo.save
          render json: todo, status: :created
        else
          render json: todo.errors, status: :unprocessable_entity
        end
    end
    
    def show
        todo = Todo.where(id: params.require(:id), user_id: $user_id)

        if todo.count != 0 
          render json: {todo: todo[0], items: Item.where(todo_id: params.require(:id))}
        else
          head :not_found
        end
    end

    def update
        todo = Todo.where(id: params.require(:id), user_id: $user_id)[0]
    
        if todo.update todo_params
          render json: todo, status: :ok
        else
          render json: todo.errors, status: :unprocessable_entity
        end
    end

    def destroy
        Todo.where(id: params.require(:id), user_id: $user_id)[0].destroy!
    
        head :ok
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
      ].min #prevents from limit > 100
    end

    def offset
        [
          params.fetch(:limit, 0).to_i,
          0
        ].max #prevets from offset < 0
    end

    def todo_params
        params.require(:todo).permit(:title, :description)
    end

    def todo_does_not_exist(e)
      render json: {error: e.message }, status: :unprocessable_entity
    end
end
