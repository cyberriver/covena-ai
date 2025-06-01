class AnalysisSession < ApplicationRecord
  has_many :chat_messages, dependent: :destroy
  has_many :metric_results
end
