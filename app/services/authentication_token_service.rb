class AuthenticationTokenService
    SECRET_KEY = "KaiserChiefs" # - Ruby
    ALGORITHM = 'HS256'

    def self.call(user_id, key)
        payload = {user_id: user_id}

        JWT.encode payload, key, ALGORITHM
    end

    def self.decode(token, key)
        decoded_token = JWT.decode token, key, true, { algorithm: ALGORITHM }
        decoded_token[0]['user_id']
    end
end
