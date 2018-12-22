bulksheet = Bulksheet.new
bulksheet.file.attach(
  io: File.open(File.join(Rails.root, '/demo_data/bulksheets/bulksheet.xlsx')),
  filename: 'bulksheet.xlsx'
)
bulksheet.save
bulksheet.analyze!
bulksheet.import!

targeting_report = Report.new
targeting_report.file.attach(
  io: File.open(File.join(Rails.root, '/demo_data/reports/sp_targeting_sep_06_dec_06.xlsx')),
  filename: 'sp_targeting_sep_06_dec_06.xlsx'
)
targeting_report.save
targeting_report.analyze!

search_term_report = Report.new
search_term_report.file.attach(
  io: File.open(File.join(Rails.root, '/demo_data/reports/sp_search_term_sep_06_dec_06.xlsx')),
  filename: 'sp_search_term_sep_06_dec_06.xlsx'
)
search_term_report.save
search_term_report.analyze!

advertised_product_report = Report.new
advertised_product_report.file.attach(
  io: File.open(File.join(Rails.root, '/demo_data/reports/sp_advertised_products_sep_06_dec_06.xlsx')),
  filename: 'sp_advertised_products_sep_06_dec_06.xlsx'
)
advertised_product_report.save
advertised_product_report.analyze!

Report.all.map(&:import!)
