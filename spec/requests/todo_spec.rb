require 'rails_helper'

describe "Todos API", type: :request do
  let!(:user) { FactoryBot.create(:user, id: 1, username: 'chris', password: '12345') } 

  it 'denies access if authentication failed' do
    get '/todos', headers: {"Authorization" => "Bearer 25151255252"}

    expect(response).to have_http_status(:unauthorized)
  end

  describe 'GET /todos' do
    let!(:todo) { FactoryBot.create(:todo, title: 'My first Todo', description: 'Testing first todo', user_id: user.id) }

    it 'returns all todos' do
        get '/todos', headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(1)
    end 
  end

  describe 'POST /todos' do
    it 'creates new todo list' do
        expect{
            post '/todos', 
            params: { 
                todo: {
                    title: 'My Test Todo List',
                    description: 'Just a todo list for testing'
                }
            },
            headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}
            
        }.to change { Todo.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
    end

    it 'returns error if title is missing' do

        post '/todos', 
        params: { 
            todo: {
                description: 'Just a todo list for testing'
            }
        },
        headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"}
            
        expect(response).to have_http_status(:unprocessable_entity)
    end
  end


end
