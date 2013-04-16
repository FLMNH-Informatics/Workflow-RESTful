class WtaskPort < ActiveRecord::Base
  attr_accessible :wtask_id, :ptype, :ploc, :pname
  belongs_to :wtask
end
