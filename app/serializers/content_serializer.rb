class ContentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  belongs_to :user
end
