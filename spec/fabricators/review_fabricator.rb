Fabricator(:review) do
  rating { 5 }
  background { Faker::Lorem.characters(160) }
  instruction { Faker::Lorem.characters(160) }
  overall { Faker::Lorem.characters(320) }
  
end