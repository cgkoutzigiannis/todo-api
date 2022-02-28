require 'rails_helper'

describe "Todos API", type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'chris', password: '12345') } 

  describe 'GET /todos' do
    let!(:todo) { FactoryBot.create(:todo, title: 'My first Todo', description: 'Testing first todo', user_id: user.id) }

    it 'returns all todos' do
        get '/todos', headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(1)
    end 
  end

  
end
