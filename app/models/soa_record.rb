class SoaRecord < ApplicationRecord
  belongs_to :zone

  def set_next_serial
    if self.schema == "timestamp"
      serial = Time.now.to_i
      save
    elsif self.schema == "YYYYMMDDVV"
      t = Time.now.utc
      y = t.year.to_s.rjust(4, '0')
      m = t.month.to_s.rjust(2, '0')
      d = t.day.to_s.rjust(2, '0')

      temp = y+m+d
      next_serial = (temp+"00").to_i
      next_serial = serial+1 if next_serial <= serial
      serial = next_serial
      save
    end
  end
end
