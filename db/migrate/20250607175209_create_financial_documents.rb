class CreateFinancialDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :financial_documents do |t|
      t.references :company, null: false, foreign_key: true
      t.string :document_type
      t.date :report_date
      t.string :status

      t.timestamps
    end

    add_index :financial_documents, [:company_id, :report_date]
  end
end
