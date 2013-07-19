class Som < ActiveRecord::Base
  def self.from_page(data, prov)
    som = self.new(DataParser.parse_self_som(data))
    prov = CGI.unescape(prov)
    uid = Uid.find_by name: prov
    som.prov_id = uid.prov_id
    return som
  end
end
