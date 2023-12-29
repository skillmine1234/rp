module Rp
  class PendingReport < ActiveRecord::Base
    belongs_to :report    
  end
end