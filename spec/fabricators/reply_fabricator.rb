Fabricator(:reply) do
  response { Faker::Lorem.words(180).join(' ') }
end