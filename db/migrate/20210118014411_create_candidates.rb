class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string       :last_name,           null: false
      t.string       :first_name,          null: false
      t.string       :last_name_kana,      null: false
      t.string       :first_name_kana,     null: false
      t.date         :birth_date,          null: false
      t.integer      :age,                 null: false
      t.string       :birth_place,         null: false
      t.integer      :gender_id,           null: false
      t.string       :Political_party,     null: false
      t.integer      :experience_id,       null: false
      t.string       :occupation,          null: false
      t.string       :education,           null: false
      t.text         :career
      t.text         :public_commitment
      t.references   :electorate, foreign_key: true
      t.timestamps
    end
  end
end
