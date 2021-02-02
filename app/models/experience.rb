class Experience < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '新人' },
    { id: 2, name: '現職' },
    { id: 3, name: '元職' }
  ]
  include ActiveHash::Associations
  has_many :candidates
end
