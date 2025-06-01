class CreateAnalysisSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :analysis_sessions do |t|
      t.string :session_token

      t.timestamps
    end
  end
end
