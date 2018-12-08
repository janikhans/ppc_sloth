module Statusable
  extend ActiveSupport::Concern

  included do
    enum status: {
      enabled: 0,
      paused: 1,
      archived: 2
    }
  end
end
