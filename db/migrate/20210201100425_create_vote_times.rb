class CreateVoteTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :vote_times do |t|
      t.datetime :vote_date_time, null: false, default: '2000-01-01 00:00:00'

      t.timestamps
    end
  end
end
