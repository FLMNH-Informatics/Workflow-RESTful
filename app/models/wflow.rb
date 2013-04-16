class Wflow < ActiveRecord::Base
  attr_accessible :name, :desc, :creator
  has_many :wtasks
end
