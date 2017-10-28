class ChartsController < ApplicationController
  def pass_fail
    render json: Session.group(:summary_status).group_by_day(:created_at).count.chart_json
  end
end
