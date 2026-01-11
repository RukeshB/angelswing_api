class Api::V1::UsersController < ApplicationController
      # POST /api/v1/users/signup
      #
      # Creates a new user account.
      #
      # @param [String] first_name Required - user's first name
      # @param [String] last_name Required - user's last name
      # @param [String] email Required - user's email (must be unique)
      # @param [String] password Required - user's password
      # @param [String] country Optional - user's country
      #
      # @return [JSON] user object with id, first_name, last_name, email, and country if successful
      # @return [JSON] errors array if creation fails
      #
      # @example Request
      #   POST /api/v1/users/signup
      #   {
      #     "first_name": "Ram",
      #     "last_name": "Basu",
      #     "email": "ram@gmail.com",
      #     "password": "password",
      #     "country": "Nepal"
      #   }
      #
      # @example Success Response
      #   HTTP 201 Created
      #   {
      #     "user": {
      #       "id": 1,
      #       "first_name": "Ram",
      #       "last_name": "Basu",
      #       "email": "ram@gmail.com",
      #       "country": "Nepal"
      #     }
      #   }
      #
      # @example Error Response
      #   HTTP 422 Unprocessable Entity
      #   {
      #     "errors": ["Email has already been taken", "First name can't be blank"]
      #   }
      def signup
        user = User.new(attributes)
        if user.save
          render json: {
            user: UserSerializer.new(user).as_json
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /api/v1/users/signin
      #
      # Authenticates a user and returns a JWT token.
      #
      # @param [String] email Required
      # @param [String] password Required
      #
      # @return [JSON] user details and JWT token if successful
      # @return [JSON] error message if authentication fails
      #
      # @example Request
      #   POST /api/v1/users/signin
      #   {
      #     "email": "aaa@gmail.com",
      #     "password": "password"
      #   }
      #
      # @example Success Response
      #   {
      #     "user": {
      #       "id": 1,
      #       "firstName": "aaa",
      #       "lastName": "bbb",
      #       "email": "aaa@gmail.com",
      #       "country": "Nepal"
      #     },
      #     "token": "jwt.token.here"
      #   }
      #
      # @example Error Response
      #   {
      #     "errors": ["Invalid email or password"]
      #   }
      def signin
        user = User.find_by(email: auth_params[:email])

        if user&.authenticate(auth_params[:password])
          token = JsonWebToken.encode(user_id: user.id)

          render json: {
            user: UserSerializer.new(user).as_json,
            token: token
          }, status: :ok
        else
          render json: {
            errors: [ "Invalid email or password" ]
          }, status: :unauthorized
        end
      end

      private

      # Strong parameters for creating a user
      #
      # @return [ActionController::Parameters] permitted parameters
      def user_params
        params.permit(:firstName, :lastName, :email, :password, :country)
      end

      # Strong parameters for user authentication
      #
      # @return [ActionController::Parameters] permitted authentication parameters
      # @param [String] email The user's email address
      # @param [String] password The user's password
      def auth_params
        params.require(:auth).permit(:email, :password)
      end

      # Builds a hash of user attributes from permitted parameters.
      #
      # @return [Hash] attributes for creating a User
      # @attribute [String] first_name The user's first name (from params[:firstName])
      # @attribute [String] last_name The user's last name (from params[:lastName])
      # @attribute [String] email The user's email address (from params[:email])
      # @attribute [String] password The user's password (from params[:password])
      # @attribute [String] country The user's country (from params[:country])
      def attributes
        {
          first_name: user_params[:firstName],
          last_name: user_params[:lastName],
          email: user_params[:email],
          password: user_params[:password],
          country: user_params[:country]
        }
      end
end
