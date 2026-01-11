class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :country, :token

  def token
    JsonWebToken.encode(user_id: object.id)
  end
end
