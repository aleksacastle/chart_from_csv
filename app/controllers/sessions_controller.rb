class SessioncController < ApplicationController
  def import
    Session.import(params[:file])
    redirect_to root_url, notice: "File was imported sucessfully"
  end
end
