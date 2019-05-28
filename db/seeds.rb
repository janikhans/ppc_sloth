def import_files(klass, directory)
  files = Dir.glob(directory + '/*.xlsx')
  files.each do |file|
    record = klass.new
    record.file.attach(
      io: File.open(File.join(Rails.root, file)),
      filename: File.basename(file, '.xlsx')
    )
    record.save
    record.analyze!
  end
end

# import_files(Bulksheet, 'demo_data/bulksheets')
import_files(Bulksheet, 'prod_data/bulksheets')
Bulksheet.all.map(&:import!)

# import_files(Report, 'demo_data/reports')
import_files(Report, 'prod_data/reports')
Report.order(period_start: :asc).map(&:import!)
