class StatsController < ApplicationController

  # GET /stats
  def index
    @stats = Stat.all.page params[:page]
  end

end
