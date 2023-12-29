require 'rails_helper'

module Rp
  RSpec.describe ReportsController, type: :controller do
    # let(:user) { FactoryGirl.create(:rp_user) }

    before do
      # @request.env["devise.mapping"] = Devise.mappings[:user]
      # sign_in user
      # allow(controller).to receive(:current_user).and_return(user)
      Rp.broker_uuid = 'ABC-123-12'
    end

    describe "GET #index" do

      let(:report) { FactoryGirl.create(:rp_report) }

      it "assigns all reports as @reports" do
        get :index
        expect(assigns(:reports)).to eq([report])
      end
    end

    describe "GET #new" do

      let(:report) { FactoryGirl.create(:rp_report) }

      it "assigns a new report as @report" do
        get :new
        expect(assigns(:report)).to be_a_new(Report)
      end
    end

    describe "POST #create" do

      let(:available_report) { FactoryGirl.create(:rp_available_report) }
      let(:report) { FactoryGirl.attributes_for(:rp_report, rp_available_reports_id: available_report.id) }

      it "creates a new Report" do
        expect {
          post :create, report
        }.to change(Report, :count).by(1)
      end

      it "assigns a newly created report as @report" do
        post :create, report
        expect(assigns(:report)).to be_a(Report)
        expect(assigns(:report)).to be_persisted
      end

      it "redirects to the reports list" do
        post :create, report
        expect(response).to redirect_to reports_path
      end
    end

  end
end
