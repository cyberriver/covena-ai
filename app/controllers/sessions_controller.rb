class SessionsController < ApplicationController
  def index
  end

  def show
  end

  def history
    @sessions = AnalysisSession
                  .includes(:metric_results)
                  .where(session_token: session[:session_token])
                  .order(created_at: :desc)
  end
end
