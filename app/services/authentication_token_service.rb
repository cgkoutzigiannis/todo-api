class AuthenticationTokenService
    SECRET_KEY = "KaiserChiefs" # - Ruby
    ALGORITHM = 'HS256'

    def self.call(user_id)
        payload = {user_id: user_id}

        JWT.encode payload, SECRET_KEY, ALGORITHM
    end

    def self.decode(token)
        decoded_token = JWT.decode token, SECRET_KEY, true, { algorithm: ALGORITHM }
        decoded_token[0]['user_id']
    end
end
