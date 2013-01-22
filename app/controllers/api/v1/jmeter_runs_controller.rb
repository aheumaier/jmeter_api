##
# Module API

module Api

  ##
  # Versioning

  module V1

    ##
    # This class represents the API part for jmeter_run_controller
    
    class JmeterRunsController < ApplicationController
      respond_to :json

      def index
        respond_with JmeterRun.all
      end

      def show
        respond_with JmeterRun.find_by_param(params[:id])
      end

      def create
        @project ||=  Project.find_by_param(params[:project_id])
        @jmeter_run = @project.jmeter_runs.build(params[:jmeter_run])
        if @jmeter_run.save
          render :json => @jmeter_run.id
        end
      end

      def update
        respond_with JmeterRun.update(params[:id], params[:project])
      end

      def destroy
        respond_with JmeterRun.destroy(params[:id])
      end

      def status
        respond_with JmeterRun.status(params[:id])
      end

      def start
        @jmeter_run ||=  JmeterRun.find(params[:id])
        @project = @jmeter_run.project_id
        @jmeter_run_start =  @jmeter_run.push_start
        render :json => "JmeterRun was successfully started."
      end

      def kill
        respond_with JmeterRun.find(params[:id])
      end

      def current
        respond_with JmeterRun.current(params[:project_id])
      end
    end
  end
end
