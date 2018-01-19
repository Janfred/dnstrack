class AddSoaRecordToZone < ActiveRecord::Migration[5.1]
  def change
    add_reference :zones, :soa_record, foreign_key: true
  end
end
