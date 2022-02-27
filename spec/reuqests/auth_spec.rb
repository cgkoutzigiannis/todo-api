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
end
