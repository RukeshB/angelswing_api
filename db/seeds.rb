puts "Seeding users..."

users_data = [
  { first_name: "Rukesh", last_name: "Basukala", email: "rukesh@gmail.com", password: "password", country: "Nepal" },
  { first_name: "Sita", last_name: "Shrestha", email: "sita@gmail.com", password: "password", country: "Nepal" },
  { first_name: "Ram", last_name: "Koirala", email: "ram@gmail.com", password: "password", country: "Nepal" }
]

users = users_data.map do |user_attrs|
  user = User.find_or_initialize_by(email: user_attrs[:email])
  user.assign_attributes(user_attrs)
  user.save!
  user
end

puts "✅ Created #{User.count} users."

puts "Seeding contents..."

users.each do |user|
  3.times do |i|
    Content.find_or_create_by!(title: "Sample Post #{i + 1} by #{user.first_name}", user: user) do |content|
      content.body = "This is the body of sample post #{i + 1} written by #{user.first_name}."
    end
  end
end

puts "✅ Created #{Content.count} contents."
puts "Seeding completed!"
