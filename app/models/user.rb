# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  country         :string
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :contents, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
