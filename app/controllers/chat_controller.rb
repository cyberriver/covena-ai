class ChatController < ApplicationController
  def index
    @session = AnalysisSession.find_or_create_by(session_token: session[:session_token])
    @messages = @session.chat_messages.order(created_at: :asc)
    @message = ChatMessage.new
  end

  def create
    @session = AnalysisSession.find_or_create_by(session_token: session[:session_token])
    @message = @session.chat_messages.create!(role: "user", content: params[:chat_message][:content])

    # Ответ от AI через Python
    ai_response = call_python_ai_service(@message.content)

    @session.chat_messages.create!(role: "ai", content: ai_response)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_index_path }
    end
  end

  private

  def call_python_ai_service(prompt)
    response = Faraday.post("http://localhost:5000/chat", { prompt: prompt }.to_json, { "Content-Type": "application/json" })
    response.success? ? JSON.parse(response.body)["reply"] : "Ошибка связи с AI-сервисом."
  end
end
