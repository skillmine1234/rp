module Rp
  class Setting < ActiveRecord::Base
    FILE_SCHEMES = {scp: 'scp', file: 'file'}

    before_create :confirm_singularity
    validates_presence_of :scheme, :max_age_days, :max_per_user
    validates_numericality_of :max_age_days, :max_per_user, { greater_than_or_equal_to: 1 }
    validate :presence_of_fields

    private
    
    def presence_of_fields
      errors[:base] << 'Username, Password & Host should not be present if scheme is file' if scheme == FILE_SCHEMES[:file] && (username.present? || password.present? || host.present?)
    end

    def confirm_singularity
      raise Exception.new("There can be only one.") if Setting.count > 0
    end
  end
end
