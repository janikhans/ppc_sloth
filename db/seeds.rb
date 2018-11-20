rand(5..10).times do
  Campaign.create!(name: Faker::Commerce.product_name)
end

Campaign.all.each do |campaign|
  rand(1..2).times do
    campaign.ad_groups.create!(name: Faker::App.name)
  end
end

AdGroup.all.each do |ad_group|
  rand(3..20).times do
    ad_group.keywords.create!(
      text: Faker::Hipster.words(rand(1..4)).join(' '),
      match_type: Keyword.match_types.keys.sample
    )
  end
end

rand(100..150).times do
  SearchTerm.create(text: Faker::Hipster.words(rand(1..4)).join(' '))
end


report = SearchTermReport.new(name: 'Test Report')
report.file.attach(
  io: File.open(File.join(Rails.root, '/test/fixtures/files/search_term_report.csv')),
  filename: 'search_term_report.csv'
)
report.save
