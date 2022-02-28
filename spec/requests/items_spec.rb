require 'rails_helper'

describe "Items API", type: :request do

  let!(:user) { FactoryBot.create(:user, id: 1, username: 'chris', password: '12345') } 
  let!(:todo) { FactoryBot.create(:todo, id: 1, title: 'My first Todo', description: 'Testing first todo', user_id: user.id) }
  let!(:item) { FactoryBot.create(:item, id: 1, content: "a task", status: false, todo_id: todo.id) }

  describe "GET todo/:id/items" do
    it 'returns a todo item' do
      get '/todos/1/items', params: {
        item_id: item.id
      },
      headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}

      expect(response).to have_http_status(:ok)
    end 
  end

  describe "PUT todo/:id/items" do
    it 'updates a todo item' do
      put '/todos/1/items', params: {
        item_id: item.id,
        item: {
          content: "an updated task",
          status: true
        }
      },
      headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}

      expect(response).to have_http_status(:ok)
    end 
  end

  describe "DELETE todo/:id/items" do
    it 'delete todo item' do 
      delete '/todos/1/items', params: {
        item_id: item.id
      },
      headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}

      expect(response).to have_http_status(:ok)
    end
  end
end
