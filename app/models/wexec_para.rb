class WexecPara < ActiveRecord::Base
  attr_accessible :wexec_id, :pname, :pcaption
  belongs_to :wexec
end
