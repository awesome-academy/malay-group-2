User.create!(name: "admin",
             email: "iamadmin@railstutorial.org",
             password: "iamadmin",
             password_confirmation: "iamadmin",
             role: 1,
             activated: true,
             role: 1,
             activated_at: Time.zone.now)

25.times do |n|
  name = Faker::Name.name
  email = "user_#{n+1}@gmail.com"
  password = "123123"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              role:0,
              activated: true,
              activated_at: Time.zone.now)
end
