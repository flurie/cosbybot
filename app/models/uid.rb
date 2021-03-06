class Uid < ActiveRecord::Base
  belongs_to :som
  validates_uniqueness_of :prov_id, :name

  def self.create_from_list data
    logger.warn "DATA = " + data
    uids = DataParser.parse_uids data
    uids.each do |params|
      if self.id_exists? params[:prov_id]
        if self.name_changed? params
          #name changed, add the name
          change = {}
          uid = Uid.find_by prov_id: params[:prov_id]
          change[:prov_id] = uid.prov_id
          change[:change] = "name"
          change[:previous] = uid.name
          change[:current] = params[:name]
          prov_change = ProvinceChange.new(change)
          prov_change.save
          uid.name = params[:name]
          uid.save
        end
        next
      else
        uid = self.new params
        unless uid.save
          return false
        end
      end
    end
    return true
  end

  def self.id_exists? id
    return (Uid.find_by prov_id: id) ? true : false
  end

  def self.name_changed? params
    return (Uid.find_by prov_id: params[:prov_id]).name != params[:name]
  end
end
