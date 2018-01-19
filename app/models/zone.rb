class Zone < ApplicationRecord
  has_paper_trail
  belongs_to :soa_record, class_name: "SOARecord", required: false
  belongs_to :parent_zone, class_name: "Zone", required: false
  has_many :child_zones, class_name: "Zone", foreign_key: "parent_zone_id"
  has_many :records

  after_create :save_soa_record, unless: :pseudo_zone

  validate :validate_soa_record_presence, on: :update
  validate :valid_parent_zone
  validate :is_a_valid_fqdn
  validate :child_zone_parent_zone_share_last_part
  validate :has_no_child_zones_which_would_be_effected

  def save_soa_record
    self.soa_record = SOARecord.get_standard_soa
    self.soa_record.save
  end

  def to_param
    fqdn
  end

  def validate_soa_record_presence
    if self.pseudo_zone
      errors.add(:soa_record_id, "A pseudo zone mustn't have a SOA-Record") unless soa_record.nil?
    else
      errors.add(:soa_record_id, "A non-pseudo zone must have a SOA Record!") if soa_record.nil?
    end
  end

  def valid_parent_zone
    return true if parent_zone_id.nil?
    parent_zone = Zone.find(parent_zone_id)
    errors.add(:parent_zone_id, "There is no such parent zone") if parent_zone.nil?
  end

  def is_a_valid_fqdn
    if fqdn=~/\.\./
      errors.add(:fqdn, "Contains two following dots")
    else
      return true if fqdn=~/[A-Za-z0-9.\-_]*/
      errors.add(:fqdn, "Contains invalid characters")
    end
  end

  def has_no_child_zones_which_would_be_effected
    return true if child_zones.empty?
    child_zones.each do |child_zone|
      next if child_zone.fqdn.ends_with?("."+parent_zone.fqdn)
      errors.add(:fqdn, "At least one child zone would get invalid if changed")
      break
    end
  end

  def child_zone_parent_zone_share_last_part
    return true if parent_zone.nil?
    return true if fqdn.ends_with?("."+parent_zone.fqdn)
    errors.add(:fqdn, "Must share the last part of the fqdn with the parent zone")
  end
end
