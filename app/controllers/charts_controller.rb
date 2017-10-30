class ChartsController < ApplicationController
  def pass_fail
    render json: Session.group(:summary_status).group_by_day(:created_at, format: "%e %b").count.chart_json
  end

  def duration_time
    render json: Session.group_by_day(:created_at, format: "%e %b").sum(:duration).chart_json
  end
end
