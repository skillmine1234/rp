module Rp
  class AvailableReportPolicy < ApplicationPolicy
    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user  = user
        @scope = scope
      end

      def resolve
        if user.has_role? Rp.editor_role
          # if she's an editor, she cal manage all 
          scope.all
        else
          # she can view public report's and reports to which she is authorized
          scope.for_user(user)
        end
      end
    end

    # she can generated public reports, and reports to which she is authorized
    def generate?
      record.authorized_user?(user)
    end

    # editor only action
    def add_authorized_user?
      user.has_role? Rp.editor_role
    end
    
    # editor only action        
    def destroy?
      user.has_role? Rp.editor_role
    end
  end
end