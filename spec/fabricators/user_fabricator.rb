Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password(6, 20) }
  full_name { Faker::Internet.user_name('tom') }
  phone { Faker::Number.number(11) }
end

Fabricator(:invalid_user, from: :user) do
  email nil
end