class BalanceSheet < ApplicationRecord
  belongs_to :financial_document
  validates :assets, :liabilities, :equity, numericality: true
end