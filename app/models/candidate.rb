class Candidate < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :Gender
  belongs_to_active_hash :Experience

  belongs_to :electorate
  has_one :room,dependent: :destroy
  has_many :votes,dependent: :destroy

  has_one_attached :image

  with_options presence: true do
    with_options format: { with: /\A[ぁ-んァ-ヶー－一-龥々]+\z/, message: 'Full-width characters' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' } do
      validates :last_name_kana
      validates :first_name_kana
    end
    with_options numericality: { other_than: 0 } do
      validates :gender_id
      validates :experience_id
    end

    validates :birth_date
    validates :age, numericality:{ greater_than_or_equal_to: 25 } ,format: { with: /\A[0-9]+\z/ , message: "is invalid. Input half-width characters"}
    validates :birth_place
    validates :political_party
    validates :occupation
    validates :education
    validates :electorate_id, uniqueness: true

  end
end
