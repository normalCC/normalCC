User.create!(name: "Example User",
  email: "Example@email.com",
  password: "pizza",
  password_confirmation: "pizza",
  birth_year: "1999",
  female: true,
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

["USA", "Canada", "China", "Korea"].each do |country|
  Country.create(name: country)
end
