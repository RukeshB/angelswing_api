class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  # Authenticate request using JWT token
  #
  # Sets @current_user if token is valid
  # Returns 401 if token is missing or invalid
  #
  # @return [void]
  def authenticate_request
    token = extract_token_from_header
    payload = JsonWebToken.decode(token)

    if payload && payload[:user_id]
      @current_user = User.find_by(id: payload[:user_id])
    end

    render_unauthorized unless @current_user
  end

  # Extract JWT token from Authorization header
  #
  # @return [String, nil]
  def extract_token_from_header
    header = request.headers["Authorization"]
    return nil unless header&.start_with?("Bearer ")

    header.split(" ").last
  end

  # Render unauthorized response
  #
  # @return [JSON]
  def render_unauthorized
    render json: { errors: [ "Not Authorized" ] }, status: :unauthorized
  end
end
