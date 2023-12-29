module Rp
  class Report < ActiveRecord::Base
    store :param1, accessors: [:param1_name, :param1_type, :param1_value], coder: JSON
    store :param2, accessors: [:param2_name, :param2_type, :param2_value], coder: JSON
    store :param3, accessors: [:param3_name, :param3_type, :param3_value], coder: JSON
    store :param4, accessors: [:param4_name, :param4_type, :param4_value], coder: JSON
    store :param5, accessors: [:param5_name, :param5_type, :param5_value], coder: JSON
    
    validate :ar_should_exist
    validate :params_should_be_correct
    validate :validate_run_at, if: "run_at.present?"
    
    has_one :pending_report

    attr_accessor :protocol, :host, :run_at, :available_report_id
    
    before_save :set_report_values, :parse_datetime

    after_create :create_pending_report
    after_create :set_report_url

    def created_by
      self[:created_by].to_i
    end

    def create_pending_report
      self.pending_report = Rp::PendingReport.new(created_at: Time.now, run_at: self.run_at, report_id: self.id, service_code: self.service_code)
    end

    private
    
    def ar_should_exist
      errors.add(:available_report_id, "Available Report not found with id #{available_report_id}") if Rp::AvailableReport.find_by_id(self.available_report_id).nil?
    end
    
    def set_report_values
      ar = Rp::AvailableReport.find(self.available_report_id)
      self.name = ar.name
      self.queued_at = Time.now
      self.state = 'NEW'
      self.mime_type = ar.mime_type
      self.dsn = ar.dsn
      self.db_unit = ar.db_unit
      self.batch_size = ar.batch_size
      self.msg_model = ar.msg_model
      self.file_ext = ar.file_ext
      self.header_kind = ar.header_kind
      self.money_format = ar.money_format
      self.normalize_space = ar.normalize_space
      self.delimiter = ar.delimiter
      self.escape_character = ar.escape_character
      self.service_code = ar.service_code
    end
    
    def parse_datetime
      self.param1_value = Time.parse(param1_value).strftime("%d-%m-%Y %I:%M:%S %p") if param1_type == 'datetime'
      self.param2_value = Time.parse(param2_value).strftime("%d-%m-%Y %I:%M:%S %p") if param2_type == 'datetime'
      self.param3_value = Time.parse(param3_value).strftime("%d-%m-%Y %I:%M:%S %p") if param3_type == 'datetime'
      self.param4_value = Time.parse(param4_value).strftime("%d-%m-%Y %I:%M:%S %p") if param4_type == 'datetime'
      self.param5_value = Time.parse(param5_value).strftime("%d-%m-%Y %I:%M:%S %p") if param5_type == 'datetime'
    end

    def set_report_url
      self.update_column(:report_url, "#{self.protocol}#{self.host}#{Rp.root_url}/reports/#{self.id}")
    end
    
    def params_should_be_correct
      validate_param(:param1, param1_name, param1_type, param1_value)
      validate_param(:param2, param2_name, param2_type, param2_value)
      validate_param(:param3, param3_name, param3_type, param3_value)
      validate_param(:param4, param4_name, param4_type, param4_value)
      validate_param(:param5, param5_name, param5_type, param5_value)
    end
  
    def validate_param(attr_name, param_name, param_type, param_value)
      errors.add(attr_name, "can't be blank") if param_name.present? and param_value.blank?
      DateTime.parse param_value rescue errors.add(attr_name, "is not a date") if ["datetime","date"].include?(param_type)
      errors.add(attr_name, "is longer than maximum (50)") if param_type == "text" and param_value.length > 50
      errors.add(attr_name, "should not include special characters") if param_type == "text" and (param_value =~ /[A-Za-z0-9]+$/).nil?
    end
    
    def validate_run_at
      run_at_as_date = DateTime.parse(run_at) 
      errors.add(:run_at, "should be a future date") if run_at_as_date < Time.zone.today
      errors.add(:run_at, "should be a date within one month") if (Time.zone.today + 30.days) < run_at_as_date
    rescue 
      errors.add(:run_at, "is not a date")
    end
  end
end
