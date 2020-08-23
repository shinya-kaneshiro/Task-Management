# coding: utf-8

User.create!(name: "Sample User",
            email: "sample@email.com",
            password: "password",
            password_confirmation: "password",
            admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end


50.times do |n|
  name  = "タスク#{n+1}"
  description = "タスク#{n+1}の詳細"
  user_id = 1
  Task.create!(name: name,
               description: description,
               user_id: user_id)
end


50.times do |n|
  name  = "タスク#{n+1}"
  description = "タスク#{n+1}の詳細"
  user_id = 2
  Task.create!(name: name,
              description: description,
              user_id: user_id)
end


50.times do |n|
  name  = "タスク#{n+1}"
  description = "タスク#{n+1}の詳細"
  user_id = 3
  Task.create!(name: name,
              description: description,
              user_id: user_id)
end