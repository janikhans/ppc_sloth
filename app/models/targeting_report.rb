class TargetingReport < Report
  def self.importable?
    true
  end

  has_many :items,
    class_name: 'TargetingReportItem',
    foreign_key: :report_id
end
