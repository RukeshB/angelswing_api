# Utility class for encoding and decoding JWT tokens
class JsonWebToken
  SECRET_KEY = ENV["JWT_SECRET_KEY"]

  # Encode a payload with expiry
  #
  # @param payload [Hash]
  # @param exp [Time] expiration time
  # @return [String] JWT token
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Decode a JWT token
  #
  # @param token [String]
  # @return [Hash, nil] decoded payload or nil if invalid
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end
end
