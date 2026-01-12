require 'rails_helper'

RSpec.describe Content do
  let(:user) do
    User.create!(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      password: 'password123'
    )
  end

  it 'is valid with valid attributes' do
    content = Content.new(title: 'Test Title', body: 'Test Body', user: user)
    expect(content).to be_valid
  end

  it 'is invalid without title' do
    content = Content.new(title: '', body: 'Test Body', user: user)
    expect(content).not_to be_valid
  end

  it 'is invalid without body' do
    content = Content.new(title: 'Test Title', body: '', user: user)
    expect(content).not_to be_valid
  end

  it 'is invalid without user' do
    content = Content.new(title: 'Test Title', body: 'Test Body')
    expect(content).not_to be_valid
  end
end