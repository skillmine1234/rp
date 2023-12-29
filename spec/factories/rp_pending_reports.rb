FactoryGirl.define do
  factory :rp_pending_report, class: 'Rp::PendingReport' do
    broker_uuid nil
    created_at '2015-12-12'
  end
end
