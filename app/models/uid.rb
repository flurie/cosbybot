class Uid < ActiveRecord::Base
  belongs_to :som
  validates_uniqueness_of :prov_id, :name
end
