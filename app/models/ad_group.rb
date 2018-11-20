class AdGroup < ApplicationRecord
  belongs_to :campaign

  has_many :keywords
end
