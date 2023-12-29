FactoryGirl.define do
  factory :rp_report, class: 'Rp::Report' do
    name 'Report1'
    state 'new'
    queued_at '2015-12-12'
    mime_type 'csv'
    created_by 'divya'
  end
end
