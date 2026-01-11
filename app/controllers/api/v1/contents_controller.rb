class Api::V1::ContentsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :set_content, only: %i[show update destroy]

  # GET /api/v1/contents
  #
  # Returns all contents created by the current user.
  #
  # @return [JSON] Array of content objects belonging to the current user
  #
  # @example Success Response
  #   HTTP 200 OK
  #   [
  #     {
  #       "id": 1,
  #       "title": "My First Content",
  #       "body": "This is the body of the content.",
  #       "user_id": 1,
  #       "created_at": "2026-01-11T12:00:00Z",
  #       "updated_at": "2026-01-11T12:00:00Z"
  #     },
  #     ...
  #   ]
  def index
    contents = Content.order(created_at: :desc)
    render json: contents, status: :ok
  end

  # GET /api/v1/contents/:id
  #
  # Returns a single content item by ID.
  #
  # @param [Integer] id Required - content ID
  # @return [JSON] content object if found
  # @return [JSON] errors array if not found
  #
  # @example Success Response
  #   HTTP 200 OK
  #   {
  #     "id": 1,
  #     "title": "My First Content",
  #     "body": "This is the body of the content.",
  #     "user_id": 1
  #   }
  #
  # @example Error Response
  #   HTTP 404 Not Found
  #   {
  #     "errors": ["Content not found"]
  #   }
  def show
    render json: Content.find(params[:id]), status: :ok
  end

  # POST /api/v1/contents
  #
  # Creates a new content item for the current user.
  #
  # @param [String] title Required - content title
  # @param [String] body Required - content body
  #
  # @return [JSON] content object with id, title, body, user_id, created_at, and updated_at if successful
  # @return [JSON] errors array if creation fails
  #
  # @example Request
  #   POST /api/v1/contents
  #   {
  #     "title": "My First Content",
  #     "body": "This is the body of the content."
  #   }
  #
  # @example Success Response
  #   HTTP 201 Created
  #   {
  #     "id": 1,
  #     "title": "My First Content",
  #     "body": "This is the body of the content.",
  #     "user_id": 1
  #   }
  #
  # @example Error Response
  #   HTTP 422 Unprocessable Entity
  #   {
  #     "errors": ["Title can't be blank", "Body can't be blank"]
  #   }
  def create
    content = current_user.contents.build(content_params)

    if content.save
      render json: content, status: :created
    else
      render json: { errors: content.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/contents/:id
  #
  # Updates an existing content item.
  #
  # @param [Integer] id Required - content ID
  # @param [String] title Optional - new title
  # @param [String] body Optional - new body
  # @return [JSON] updated content object if successful
  # @return [JSON] errors array if update fails
  #
  # @example Request
  #   PATCH /api/v1/contents/1
  #   {
  #     "title": "Updated Title",
  #     "body": "Updated body."
  #   }
  #
  # @example Success Response
  #   HTTP 200 OK
  #   {
  #     "id": 1,
  #     "title": "Updated Title",
  #     "body": "Updated body.",
  #     "user_id": 1
  #   }
  #
  # @example Error Response
  #   HTTP 422 Unprocessable Entity
  #   {
  #     "errors": ["Title can't be blank"]
  #   }
  def update
    if @content.update(content_params)
      render json: @content, status: :ok
    else
      render json: { errors: @content.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/contents/:id
  #
  # Deletes a content item by ID.
  #
  # @param [Integer] id Required - content ID
  # @return [nil]
  #
  # @example Success Response
  #   HTTP 204 No Content
  def destroy
    @content.destroy
    head :no_content
  end

  private

  # Finds and sets the content for actions requiring an ID.
  #
  # @param [Integer] id Required - content ID
  # @return [Content] The found content object
  def set_content
    @content = current_user.contents.find_by(id: params[:id])

    render json: { errors: [ "Content not found" ] },
           status: :unprocessable_entity unless @content
  end

  # Strong parameters for content creation and update.
  #
  # @return [ActionController::Parameters] Permitted parameters for content
  # @param [String] title The title of the content
  # @param [String] body The body of the content
  def content_params
    params.require(:content).permit(:title, :body)
  end
end
