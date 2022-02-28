require 'rails_helper'

describe 'Athentication', type: :request do

    describe 'POST /signup' do

        it 'creates new user' do
            expect {
                post '/signup', params: { username: 'chris', password: '12345' }
            }.to change { User.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end

        it 'returns conflict when user exists' do
            FactoryBot.create(:user, username: 'chris', password: '12345')
            post '/signup', params: { username: 'chris', password: '12345' } #twice

            expect(response).to have_http_status(:conflict)
            expect(JSON.parse(response.body)).to eq({
                'error' => "PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint \"index_users_on_username\"\nDETAIL:  Key (username)=(chris) already exists.\n"
            })
            expect(User.count).to eq(1)
        end

        it 'returns error when username is missing' do
            post '/signup', params: { password: '12345' }

            expect(response).to have_http_status(:unprocessable_entity)
            expect( JSON.parse(response.body) ).to eq({
                'error' => "param is missing or the value is empty: username"
            })
            expect(User.count).to eq(0)
        end

        it 'returns error when password is missing' do
            post '/signup', params: { username: 'chris' }

            expect(response).to have_http_status(:unprocessable_entity)
            expect( JSON.parse(response.body) ).to eq({
                'error' => "param is missing or the value is empty: password"
            })
            expect(User.count).to eq(0)
        end
    end

    describe 'POST /login' do

        let!(:user) { FactoryBot.create(:user, id: 1, username: 'chris', password: '12345') }

        it 'authenticates a user' do
            post '/auth/login', params: { username: user.username, password: user.password }

            expect(response).to have_http_status(:created)
            expect( JSON.parse(response.body) ).to eq({
                "token" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA"
            })
        end

        it 'returns error when username is missing' do
            post '/auth/login', params: { password: user.password }

            expect(response).to have_http_status(:unprocessable_entity)
            expect( JSON.parse(response.body) ).to eq({
                'error' => "param is missing or the value is empty: username"
            })
        end

        it 'returns error when password is missing' do
            post '/auth/login', params: { username: user.username }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)).to eq({
                'error' => "param is missing or the value is empty: password"
            })
        end

        it 'returns error when password is wrong' do
            post '/auth/login', params: { username: user.username, password: "wrong_password" }

            expect(response).to have_http_status(:unauthorized)
            expect(JSON.parse(response.body)).to eq({
                'error' => "AuthController::AuthenticationError"
            })
        end

        it 'returns error when username is wrong' do
            post '/auth/login', params: { username: 'wrong_username', password: user.password }

            expect(response).to have_http_status(:unauthorized)
        end
    end
end
