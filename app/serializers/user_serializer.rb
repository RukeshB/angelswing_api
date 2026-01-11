# UserSerializer
#
# Serializes a User object in JSON:API format with nested attributes and token.
#
# Example output:
# {
#   "id": 1,
#   "type": "user",
#   "attributes": {
#     "first_name": "John",
#     "last_name": "Doe",
#     "email": "john@email.com",
#     "country": "USA",
#     "token": "jwt.token.here"
#   }
# }
class UserSerializer < ActiveModel::Serializer
  attributes :id

  attribute :type do
    "user"
  end

  attribute :attributes do
    {
      first_name: object.first_name,
      last_name: object.last_name,
      email: object.email,
      country: object.country,
      token: token
    }
  end

  def token
    JsonWebToken.encode(user_id: object.id)
  end
end
