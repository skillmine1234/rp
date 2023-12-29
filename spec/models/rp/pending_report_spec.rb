require 'rails_helper'

module Rp
  RSpec.describe PendingReport, type: :model do
    context 'association' do
      it { should belong_to(:report) }
    end

    context 'validate' do
      it 'should be not valid when broker_uuid is not set' do
        Rp.broker_uuid = nil
        pending_report = FactoryGirl.build(:rp_pending_report)
        expect(pending_report.valid?).to eq(false)
      end

      it 'should be valid when broker_uuid is set' do
        Rp.broker_uuid = 'ABC-123-12'
        pending_report = FactoryGirl.build(:rp_pending_report)
        expect(pending_report.valid?).to eq(true)
      end
    end
  end
end
