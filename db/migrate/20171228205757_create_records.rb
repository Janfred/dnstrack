class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :zone, foreign_key: true
      t.string :name
      t.integer :ttl
      t.string :type
      t.integer :priority
      t.string :target

      t.timestamps
    end
  end
end
