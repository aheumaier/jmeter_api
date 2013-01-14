module Api
  module V1
    class JmeterRunsController < ApplicationController
      respond_to :json

      def index
        respond_with JmeterRun.all
      end


      def show
        respond_with JmeterRun.find_by_param(params[:id])
      end


      def create
        respond_with JmeterRun.create(params[:project])
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
        respond_with JmeterRun.start(params[:id])
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
