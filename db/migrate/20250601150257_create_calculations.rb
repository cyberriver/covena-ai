class CreateCalculations < ActiveRecord::Migration[7.1]
  def change
    create_table :calculations do |t|
      t.string :metric
      t.decimal :value
      t.text :explanation
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
