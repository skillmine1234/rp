module Rp
  class ReportPolicy < ApplicationPolicy
    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user  = user
        @scope = scope
      end

      def resolve
        scope.where(created_by: user.id)
      end
    end
    
    def download?
      record.created_by == user.id || record.created_by.zero?
    end
    
    def retry?
      record.created_by == user.id
    end
  end
end