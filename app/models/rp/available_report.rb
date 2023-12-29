module Rp
  class AvailableReport < ActiveRecord::Base
    enum param_types: [:number, :date, :text, :datetime]
    MIME_TYPES = %w(text/csv text/plain text/xml)
    FILE_EXT = %w(csv txt xml)
    MONEY_FORMATS = %w(###,###,##0.00 ########0.00)
    HEADER_KINDS = [['Column Header', 'C'], ['Data Header', 'D'], ['None', 'N']]
    
    has_many :authorized_users
    has_many :users, through: :authorized_users, class_name: "User"
    
    store :param1, accessors: [:param1_name, :param1_type], coder: JSON
    store :param2, accessors: [:param2_name, :param2_type], coder: JSON
    store :param3, accessors: [:param3_name, :param3_type], coder: JSON
    store :param4, accessors: [:param4_name, :param4_type], coder: JSON
    store :param5, accessors: [:param5_name, :param5_type], coder: JSON

    validates_uniqueness_of :code
    validates_presence_of :name, :dsn, :batch_size, :db_unit, :code
    validates_presence_of :param1_name, unless: "param2_name.blank?", message: "can't be blank when Param2 name is present"
    validates_presence_of :param2_name, unless: "param3_name.blank?", message: "can't be blank when Param3 name is present"
    validates_presence_of :param3_name, unless: "param4_name.blank?", message: "can't be blank when Param4 name is present"
    validates_presence_of :param4_name, unless: "param5_name.blank?", message: "can't be blank when Param5 name is present"
    validates_numericality_of :batch_size, { greater_than_or_equal_to: 1 }
    validate :values_of_delimiter_and_escape_character

    before_save :set_param_cnt, :set_file_ext
    
    def authorized_user?(user)
      is_public == 'Y' || authorized_users.where(user_id: user.id).exists?
    end
    
    # all public reports, and all private reports to whom the user is authorized
    def self.for_user(user)
      available_report = AvailableReport.arel_table
      authorized_user = AuthorizedUser.arel_table
      
      constraints = available_report.create_on(
                      available_report[:id].eq(authorized_user[:available_report_id]).
                        and(authorized_user[:user_id].eq(user.id))).
                        and(available_report[:is_public].eq('N'))
      
      join = available_report.create_join(authorized_user, constraints)

      authorized_and_public = AvailableReport.joins(join).union(:all, available_report.project(available_report[Arel.star]).where(available_report[:is_public].eq('Y')))          
      
      AvailableReport.from(available_report.create_table_alias(authorized_and_public, 'rp_available_reports'))
    end
    
    def set_file_ext
      index = MIME_TYPES.find_index(mime_type)
      self.file_ext = FILE_EXT[index]
    end
    
    private
    def set_param_cnt
      self.params_cnt = 0
      self.params_cnt += 1 unless param1_name.blank?
      self.params_cnt += 1 unless param2_name.blank?
      self.params_cnt += 1 unless param3_name.blank?
      self.params_cnt += 1 unless param4_name.blank?
      self.params_cnt += 1 unless param5_name.blank?      
    end
    
    def values_of_delimiter_and_escape_character
      errors.add(:delimiter, "should be ',' when mime_type is text/csv") if mime_type == 'text/csv' && delimiter != ','
      errors.add(:escape_character, 'should be " when mime_type is text/csv') if mime_type == 'text/csv' && escape_character != '"'
      errors.add(:escape_character, "can't be same as the delimiter") if delimiter == escape_character
    end
  end
end
