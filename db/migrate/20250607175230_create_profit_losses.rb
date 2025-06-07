class CreateProfitLosses < ActiveRecord::Migration[7.2]
  def change
    create_table :profit_losses do |t|
      t.references :financial_document, null: false, foreign_key: true
      t.decimal :revenue
      t.decimal :net_profit
      t.decimal :ebitda

      t.timestamps
    end
  end
end
