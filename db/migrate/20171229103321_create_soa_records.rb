class CreateSoaRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :soa_records do |t|
      t.string :primary_ns
      t.string :contact
      t.integer :serial
      t.integer :refresh
      t.integer :retry
      t.integer :expire
      t.integer :ttl
      t.string :serial_schema
      t.boolean :committed, default: false, null: false

      t.timestamps
    end
  end
end
