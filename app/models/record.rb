require 'resolv'
class Record < ApplicationRecord

  ALLOWED_RRTYPES=%w{A AAAA CNAME MX NS DS PTR SRV TXT}
  NOT_SUPPORTED_RRTYPES=%w{NAPTR DNAME DNSKEY RRSIG NSEC NSEC3 NSEC3PARAM TLSA}
  DEPRECATED_RRTYPES=%w{A6 SPF}

  belongs_to :zone
  has_paper_trail

  validate :check_valid_rrtype
  validate :check_valid_record_target

  before_save :before_save_commit_reset

  def before_save_commit_reset
    $stderr.puts changes.inspect
    return if changes.empty?
    return if changes.include? "committed"
    self.committed = false
  end

  def check_valid_rrtype
    rrtype.upcase!
    return true if ALLOWED_RRTYPES.include? rrtype
    if NOT_SUPPORTED_RRTYPES.include? rrtype
      errors.add(:rrtype, "This RR type is currently not supported")
    elsif DEPRECATED_RRTYPES.include? rrtype
      errors.add(:rrtype, "This RR type is deprecated")
    else
      errors.add(:rrtype, "This is not a valid RR type")
    end
  end

  def check_valid_record_target
    rrtype.upcase!
    $stderr.puts "check_valid_#{self.rrtype}_record"
    if self.respond_to? ("check_valid_#{self.rrtype}_record".to_sym)
      self.send("check_valid_#{self.rrtype}_record".to_sym)
    else
      errors.add(:rrtype, "Could not check format of target")
    end
  end

  def check_valid_A_record
    return true if !!(self.target =~ Resolv::IPv4::Regex)
    errors.add(:target, "Not a valid IPv4 Address")
  end
  def check_valid_AAAA_record
    return true if !!(self.target =~ Resolv::IPv6::Regex)
    errors.add(:target, "Not a valid IPv6 Address")
  end
  def check_valid_CNAME_record
    # TODO
  end
  def check_valid_SRV_record
    # TODO
  end
  def check_valid_MX_record
    # TODO
  end
  def check_valid_NS_record
    # TODO
  end
  def check_valid_DS_record
    # TODO
  end
  def check_valid_TXT_record
    # TODO
  end
  def check_valid_PTR_record
    # TODO
  end
end
