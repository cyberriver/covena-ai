class ProfitLoss < ApplicationRecord
  belongs_to :financial_document
  validates :revenue, :net_profit, :ebitda, numericality: true
end