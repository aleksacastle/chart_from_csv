class SessionsController < ApplicationController
  def index
    @sessions = Session.order(:created_at)
    respond_to do |format|
      format.html
      format.csv
    end
  end

  def import
    Session.import(params[:file])
    redirect_to root_url, notice: "File was imported sucessfully"
  end
end
