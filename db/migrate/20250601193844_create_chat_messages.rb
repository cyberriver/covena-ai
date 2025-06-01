class CreateChatMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_messages do |t|
      t.references :analysis_session, null: false, foreign_key: true
      t.string :role
      t.text :content

      t.timestamps
    end
  end
end
