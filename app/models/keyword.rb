class Keyword < ApplicationRecord
  belongs_to :ad_group

  enum match_type: {
    broad: 0,
    phrase: 1,
    exact: 2
  }
end
