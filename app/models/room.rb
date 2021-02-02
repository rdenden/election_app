class Room < ApplicationRecord
  belongs_to :candidate
  has_many :messages
end
