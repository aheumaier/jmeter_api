##
# API-Module
#
# This encapsulates all the API functionality.
#
module Api

  ##
  # Versioning
  # 
  # This enables us to administer multiple versions of the API without changing the core.
  #
  module V1

    ##
    # This class holds all methods to interact with the JMeter-Client-API.
    # 
    # Accepts only JSON input.
    #
    # [Args]   small domestic animal
    # [+Args+] command to copy standard input
    #
    class JmeterRunsController < ApplicationController
      respond_to :json

      def index
        respond_with JmeterRun.all
      end

      def show
        respond_with JmeterRun.find_by_param(params[:id])
      end

      ##
      #
      # Creates a new JMeter-Run
      #
      # [+Args+]
      #   - +project_id+ ->
      #   - +jmeter_run+ -> hash of {"jmx_definition_file_id", "description"}
      #   
      # Args::   small domestic animal
      # +Args+:: command to copy standard input
      #
      # = Level One Heading
      # == Level Two Heading
      #
      # * *Args*:
      #   - +project_id+ ->
      #   - +jmeter_run+ -> hash of {"jmx_definition_file_id", "description"}
      # * *Returns*:
      #   - +jmeter_run.id+ -> the id of the just created run
      # * *Raises*:
      #   - +ArgumentError+ -> if any value is nil or negative
      #
      def create
        @project ||=  Project.find_by_param(params[:project_id])
        puts @project.inspect

        @jmeter_run = @project.jmeter_runs.build(params[:jmeter_run])
        puts @jmeter_run.inspect

        if @jmeter_run.save
          render :json => @jmeter_run.id
        else
          render :json => "JMeter-Run NOT created!"
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

      ##
      # Starts a JMeter-Run
      #
      # * *Args*:
      #   - +id+ -> The ID of the JMeter-Run in question
      # * *Returns*:
      #   - +String+ -> Just a status message.
      # * *Raises*:
      #   - +ArgumentError+ -> if any value is nil or negative
      #
      #
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
