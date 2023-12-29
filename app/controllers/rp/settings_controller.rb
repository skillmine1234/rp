require_dependency "rp/application_controller"

module Rp
  class SettingsController < ApplicationController
    before_action :set_setting, only: [:edit, :update, :destroy]

    def new
      @setting = Rp::Setting.new
      authorize @setting
    end

    def create
      @setting = Rp::Setting.new(setting_params)

      if @setting.save
        redirect_to settings_path, notice: 'Setting was successfully created.'
      else
        render :new
      end
    end

    def index
      @settings = Rp::Setting.all
      @settings_count = @settings.count
    end

    def edit
      authorize @setting
    end

    def update
      if @setting.update(setting_params)
        redirect_to settings_path, notice: 'Setting was successfully updated.'
      else
        render :edit
      end
    end

    private
      def set_setting
        @setting = Rp::Setting.find(params[:id])
      end

      def setting_params
        params.require(:setting).permit(:scheme, :host, :username, :password, :port, :virtual_path, :max_age_days, :max_per_user, :query_timeout)
      end
  end
end
