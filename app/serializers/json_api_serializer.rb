class JsonApiSerializer
  def initialize(resource)
    @resource = resource
  end

  def as_json(*_args)
    type = @resource.class.name.underscore
    attrs =
      case type
      when "user"
        UserSerializer.new(@resource).as_json.except(:id)
      when "content"
        ContentSerializer.new(@resource).as_json.except(:id)
      else
        @resource.attributes.except("id")
      end
    {
      id: @resource.id,
      type: type,
      attributes: attrs
    }
  end
end
