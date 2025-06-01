require 'faraday'
require 'faraday/multipart'

class CalculationsController < ApplicationController
  def create
  end

  def analyze
    file1 = params[:form1]
    file2 = params[:form2]
    metrics = params[:metrics] || ["EBITDA", "DEBT/EBITDA"]

    conn = Faraday.new(
      url: "http://analyzer:5001",
      headers: { 'Content-Type' => 'multipart/form-data' }
    ) do |f|
      f.request :multipart
      f.request :url_encoded
      f.adapter Faraday.default_adapter
    end

    payload = {
      form1: Faraday::Multipart::FilePart.new(file1.tempfile, file1.content_type, file1.original_filename),
      form2: Faraday::Multipart::FilePart.new(file2.tempfile, file2.content_type, file2.original_filename),
      metrics: metrics
    }

    response = conn.post("/analyze", payload)

    if response.success?
      @results = JSON.parse(response.body)
      # Сохраняем анализ
      session_record = AnalysisSession.create!(session_token: session[:session_token])
      @results.each do |r|
        session_record.metric_results.create!(
          metric: r["metric"],
          value: r["value"],
          explanation: r["explanation"]
        )
      end

    else
      @error = "Ошибка при вызове Python-сервиса: #{response.status}"
    end
  end

end
