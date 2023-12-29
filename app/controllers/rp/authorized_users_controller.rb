require_dependency "rp/application_controller"

module Rp
  class AuthorizedUsersController < ApplicationController    
    def create
      @authorized_user = AuthorizedUser.new(authorized_report_params)

      if @authorized_user.save
        redirect_to authorized_users_path(available_report_id: authorized_report_params[:available_report_id]), notice: 'User was successfully authorized.'
      else
        redirect_to authorized_users_path(available_report_id: authorized_report_params[:available_report_id]), notice: @authorized_user.errors.full_messages
      end
    end
    
    def index
      @available_reports = AvailableReport.where(is_public: 'N')
      if params[:available_report_id]
        @available_report = AvailableReport.find(params[:available_report_id])
        @authorized_users = AuthorizedUser.where(available_report_id: params[:available_report_id])
      end
    end
    
    def destroy
      @authorized_user = AuthorizedUser.find(params[:id])
      @authorized_user.destroy
      redirect_to available_reports_path(private: true), notice: 'Report was successfully deleted.'
    end
    
    private
    def authorized_report_params
      params.require(:authorized_user).permit(:username, :available_report_id)
    end
  end
end
