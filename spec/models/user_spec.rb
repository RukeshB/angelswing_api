require 'rails_helper'

RSpec.describe User do
  it 'is valid with valid attributes' do
    user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      password: 'password123'
    )
    expect(user).to be_valid
  end

  it 'is invalid without first_name' do
    user = User.new(first_name: '', last_name: 'Doe', email: 'john@example.com', password: 'password123')
    expect(user).not_to be_valid
  end

  it 'is invalid without last_name' do
    user = User.new(first_name: 'John', last_name: '', email: 'john@example.com', password: 'password123')
    expect(user).not_to be_valid
  end

  it 'is invalid without email' do
    user = User.new(first_name: 'John', last_name: 'Doe', email: '', password: 'password123')
    expect(user).not_to be_valid
  end

  it 'is invalid with duplicate email' do
    User.create!(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password123')
    user = User.new(first_name: 'Jane', last_name: 'Smith', email: 'john@example.com', password: 'password456')
    expect(user).not_to be_valid
  end

  it 'is invalid without password' do
    user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com')
    expect(user).not_to be_valid
  end
end