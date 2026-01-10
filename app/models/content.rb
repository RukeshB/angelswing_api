# == Schema Information
#
# Table name: contents
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_contents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Content < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
end
