class SOARecord < ApplicationRecord
  has_one :zone

  def self.get_standard_soa
    soa_record = SOARecord.new
    soa_record.serial  =     1
    soa_record.refresh = 86400
    soa_record.retry   =  7200
    soa_record.expire  =  1000
    soa_record.ttl     =   900
    soa_record.serial_schema = "increment"
    soa_record
  end

  def set_next_serial
    if self.serial_schema == "timestamp"
      self.serial = Time.now.to_i
      self.save
    elsif self.serial_schema == "YYYYMMDDVV"
      t = Time.now.utc
      y = t.year.to_s.rjust(4, '0')
      m = t.month.to_s.rjust(2, '0')
      d = t.day.to_s.rjust(2, '0')

      temp = y+m+d
      next_serial = (temp+"00").to_i
      next_serial = self.serial+1 if next_serial <= self.serial
      self.serial = next_serial
      self.save
    elsif self.serial_schema == "increment"
      self.serial = self.serial + 1
      self.save
    end
  end
end
