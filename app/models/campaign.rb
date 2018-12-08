class Campaign < ApplicationRecord
  include Statusable

  has_many :ad_groups

  enum targeting_type: {
    auto: 0,
    manual: 1
  }
end
