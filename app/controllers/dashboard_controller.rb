class DashboardController < ApplicationController
  def index
     @jobs ||= Delayed::Job.all
  end
end
