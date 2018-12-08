class AdGroup < ApplicationRecord
  include Statusable
  
  belongs_to :campaign

  has_many :keywords

  has_many :ads
end
