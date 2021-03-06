module Api
  module V1
    class ProjectsController < ApplicationController
      respond_to :json

      def index
        respond_with Project.all
      end

      def show
        respond_with Project.find_by_param(params[:id])
      end

      def create
        respond_with Project.create(params[:project])
      end

      def update
        respond_with Project.update(params[:id], params[:project])
      end

      def destroy
        respond_with Project.destroy(params[:id])
      end

      def exists
        respond_with Project.find_or_create_by_param(params)
      end
    end
  end
end

