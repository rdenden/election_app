class RenamePoliticalPartyColumnToCandidates < ActiveRecord::Migration[6.0]
  def change
    rename_column :candidates, :Political_party, :political_party
  end
end
