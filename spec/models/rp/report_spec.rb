require 'rails_helper'

module Rp
  RSpec.describe Report, type: :model do
    context 'association' do
      it { should have_one(:pending_report) }
      it { should accept_nested_attributes_for(:pending_report) }
    end

    context 'enqueue_report' do
      it 'should enqueue report when broker_uuid is set' do
        Rp.broker_uuid = 'ABC-123-12'
        report = FactoryGirl.build(:rp_report)
        expect(report.save).to eq(true)
        expect(report.pending_report).not_to be_nil
      end
    end
  end
end
