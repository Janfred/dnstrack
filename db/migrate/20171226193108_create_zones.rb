class CreateZones < ActiveRecord::Migration[5.1]
  def change
    create_table :zones do |t|
      t.string :fqdn
      t.boolean :psedo_zone
      t.string :description
      t.references :parent_zone

      t.timestamps
    end
  end
end
