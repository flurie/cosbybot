class Sot < ActiveRecord::Base
  def self.from_page(data, prov)
    sot = self.new(DataParser.parse_self_sot(data))
    prov = CGI.unescape(prov)
    uid = Uid.find_by name: prov
    sot.prov_id = uid.prov_id
    return sot
  end

  def self.enemy_from_page(data, prov_id)
    sot = self.new(DataParser.parse_enemy_sot(data))
    sot.prov_id = prov_id
    return sot
  end
  
end
