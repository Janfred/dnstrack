class Record < ApplicationRecord
  belongs_to :zone
  has_paper_trail
end
