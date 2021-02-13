class Vote < ApplicationRecord
  belongs_to :electorate
  belongs_to :candidate

  validates :electorate_id, uniqueness: true, presence: true
  validates :candidate_id, presence: true
end
