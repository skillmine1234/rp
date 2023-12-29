class RenameColumnDataHeaderToHeaderKind < ActiveRecord::Migration[7.0]
  def change
    rename_column :rp_available_reports, :data_header, :header_kind
    Rp::AvailableReport.where(header_kind: 'N').update_all(header_kind: 'C')
    Rp::AvailableReport.where(header_kind: 'Y').update_all(header_kind: 'D')
    change_column :rp_available_reports, :header_kind, :string, limit: 1, default: 'C', comment: 'the indicator which says whether this report needs a Column Header(C), Data Header(D) or No Header(N)'  
    
    rename_column :rp_reports, :data_header, :header_kind
    Rp::Report.where(header_kind: 'N').update_all(header_kind: 'C')
    Rp::Report.where(header_kind: 'Y').update_all(header_kind: 'D')
    change_column :rp_reports, :header_kind, :string, limit: 1, default: 'C', comment: 'the indicator which says whether this report needs a Column Header(C), Data Header(D) or No Header(N)'
  end
end
