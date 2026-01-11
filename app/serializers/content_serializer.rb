class ContentSerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at, :updated_at

  belongs_to :user
end
