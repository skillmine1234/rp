module Rp
  class SettingPolicy < ApplicationPolicy
    def edit?
      user.has_role? Rp.editor_role
    end

    def index?
      user.has_role? Rp.editor_role
    end
    
    def new?
      user.has_role? Rp.editor_role
    end
  end
end