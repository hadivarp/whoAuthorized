require 'jwt'


class JsonWebToken
  ALGORITHM = 'HS256'

  def self.encode(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)

    return {} if token.nil?

    JWT.decode(token, auth_secret, true, algorithm: ALGORITHM)[0]

  end


  def self.auth_secret
    ENV['SECRET_KEY_BASE']
  end
end