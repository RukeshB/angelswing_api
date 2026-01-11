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

  # Render a resource in the standard JSON:API format
  #
  # @param [ActiveRecord::Base, Array, Hash] data The resource or array of resources to render
  # @param [Symbol] status HTTP status (default: :ok)
  #
  # The resource(s) must respond to .id, .attributes, and .class.name (for type).
  def render_json_api(data, status = :ok)
    if data.is_a?(Array) || data.is_a?(ActiveRecord::Relation)
      render json: {
        data: data.map { |resource| JsonApiSerializer.new(resource).as_json }
      }, status: status
    else
      render json: { data: JsonApiSerializer.new(data).as_json }, status: status
    end
  end
end
