class ItemsController < ApplicationController

    include ActionController::HttpAuthentication::Token

    before_action :authenticate_user, :todo

    def create 
        item = Item.where(id: params.require(:item_id), todo_id: todo.id)[0]

        if item.save
            render json: item, status: :created
        else
            render json: item.errors, status: :unprocessable_entity
        end
    end

    def show
        item = Item.where(id: params.require(:item_id), todo_id: todo.id)

        render json: item, status: :ok

    rescue NoMethodError
        render status: :unprocessable_entity
    end

    def update
        item = Item.where(id: params.require(:item_id), todo_id: todo.id)[0]

        if item.update item_params
            render json: item, status: :ok
        else
            render json: item.errors, status: :unprocessable_entity
        end
    end

    def destroy
        item = Item.where(id: params.require(:item_id), todo_id: todo.id)[0].destroy!

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

    def todo
        @todo ||= Todo.where(id: params.require(:id), user_id: $user_id)[0]
    rescue ActiveRecord::RecordNotFound
        render status: :not_found
    end

    def item_params
        params.require(:item).permit(:content, :status)
    end
end