require 'jwt'


class JsonWebToken
  ALGORITHM = 'HS256'

  def self.encode(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end



  def self.decode(token)


    return {} if token.nil?
    begin
      # Remove "Bearer " prefix before decoding
      token_without_bearer = token.gsub(/^Bearer /, '')
      decoded = JWT.decode(token_without_bearer, auth_secret, true, { algorithm: ALGORITHM })


      decoded_payload = decoded.first

      validate_payload(decoded_payload)

      decoded_payload

    rescue JWT::DecodeError => e
      handle_decode_error(e)
    end
  end


  def self.auth_secret
    ENV['SECRET_KEY_BASE']
  end



  def self.validate_payload(payload)
    unless payload['user_id']
      raise JWT::InvalidPayload, 'Missing user_id'
    end
    #todo
    # check expireation as second parameters
    # unless Time.now < Time.at(payload['exp'])
    #   raise JWT::ExpiredSignature, 'Token expired'
    # end
  end

  def self.handle_decode_error(error)
    Rails.logger.error("Decode error: #{error.message}")
    nil
  end
end