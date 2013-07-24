class Kingdom < ActiveRecord::Base
  include ActiveModel::Dirty
  before_save :check_changes

  private

  def check_changes
    previous = Kingdom.where(loc: loc).last
    if previous && name != previous.name
      kdchange = KingdomChange.new({loc: loc, change: "name",
                                     previous: previous.name,
                                     current: name})
      kdchange.save
    end
    if previous && stance != previous.stance
      kdchange = KingdomChange.new({loc: loc, change: "stance",
                                     previous: previous.stance,
                                     current: stance})
      kdchange.save
    end

  end
end
