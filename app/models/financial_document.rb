class FinancialDocument < ApplicationRecord
  belongs_to :company
  has_one :balance_sheet, dependent: :destroy
  has_one :profit_loss, dependent: :destroy
  
  enum document_type: { balance: 0, profit_loss: 1, cash_flow: 2 }
  validates :report_date, presence: true
 

end