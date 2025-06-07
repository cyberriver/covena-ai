class CreateBalanceSheets < ActiveRecord::Migration[7.2]
  def change
    create_table :balance_sheets do |t|
      t.references :financial_document, null: false, foreign_key: true
      t.decimal :assets
      t.decimal :liabilities
      t.decimal :equity

      t.timestamps
    end
  end
end
