class AddCommittedToRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :committed, :boolean
  end
end
