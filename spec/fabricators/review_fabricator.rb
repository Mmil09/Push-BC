Fabricator(:review) do
  rating { 5 }
  background { Faker::Lorem.words(160).join(' ') }
  instruction { Faker::Lorem.words(160).join(' ') }
  overall { Faker::Lorem.words(249).join(' ') }
  
end