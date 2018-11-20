rand(5..10).times do
  Campaign.create!(name: Faker::Commerce.product_name)
end

Campaign.all.each do |campaign|
  rand(1..2).times do
    campaign.ad_groups.create(name: Faker::App.name)
  end
end
