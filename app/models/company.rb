class Company < ApplicationRecord
  has_many :financial_documents, dependent: :destroy
  
  validates :inn, presence: true,
                  length: { in: 10..12 },
                  numericality: { only_integer: true },
                  uniqueness: true
end
