module Rp
  module ApplicationHelper
    def l(object, options = {})
      super(object, options) if object
    end    
  end
end
