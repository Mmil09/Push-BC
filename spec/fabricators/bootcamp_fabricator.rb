Fabricator(:bootcamp) do
  name { Faker::Name.name }
  description { Faker::Lorem.sentences(5).join(" ") }
  
end