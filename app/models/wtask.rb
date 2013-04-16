class Wtask < ActiveRecord::Base
  attr_accessible :wflow_id, :exe_id, :inline, :name, :wtask_status
  has_many :wtask_ports
  belongs_to :wflow
  has_many :wexecs
end
