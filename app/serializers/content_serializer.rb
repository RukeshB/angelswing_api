# ContentSerializer
#
# Serializes a Content object in JSON:API format with nested attributes.
#
# Example output:
# {
#   "id": 1,
#   "type": "content",
#   "attributes": {
#     "title": "Content Title",
#     "body": "Content body text.",
#     "created_at": "2026-01-11T12:00:00Z",
#     "updated_at": "2026-01-11T12:00:00Z"
#   }
# }
class ContentSerializer < ActiveModel::Serializer
  attributes :id

  attribute :type do
    "content"
  end

  attribute :attributes do
    {
      title: object.title,
      body: object.body,
      created_at: object.created_at,
      updated_at: object.updated_at
    }
  end
end
