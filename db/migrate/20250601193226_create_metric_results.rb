class CreateMetricResults < ActiveRecord::Migration[7.2]
  def change
    create_table :metric_results do |t|
      t.references :analysis_session, null: false, foreign_key: true
      t.string :metric
      t.string :value
      t.text :explanation

      t.timestamps
    end
  end
end
