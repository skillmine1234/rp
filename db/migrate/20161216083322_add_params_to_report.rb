class AddParamsToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_available_reports, :params_cnt, :integer, comment: 'the count of parameters needed to generate this report'
    add_column :rp_available_reports, :param1, :string, limit: 500, comment: 'the parameter needed to generate this report'
    add_column :rp_available_reports, :param2, :string, limit: 500, comment: 'the parameter needed to generate this report'
    add_column :rp_available_reports, :param3, :string, limit: 500, comment: 'the parameter needed to generate this report'
    add_column :rp_available_reports, :param4, :string, limit: 500, comment: 'the parameter needed to generate this report'
    add_column :rp_available_reports, :param5, :string, limit: 500, comment: 'the parameter needed to generate this report'

    add_column :rp_reports, :params_cnt, :integer, comment: 'the count of parameters for this report'
    add_column :rp_reports, :param1, :string, comment: 'the parameter to generate this report'
    add_column :rp_reports, :param2, :string, comment: 'the parameter to generate this report'
    add_column :rp_reports, :param3, :string, comment: 'the parameter to generate this report'
    add_column :rp_reports, :param4, :string, comment: 'the parameter to generate this report'
    add_column :rp_reports, :param5, :string, comment: 'the parameter to generate this report'
  end
end
