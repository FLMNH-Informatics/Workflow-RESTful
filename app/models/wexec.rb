class Wexec < ActiveRecord::Base
  attr_accessible :name, :eloc
  has_many :wexec_paras
  belongs_to :wtask
end
