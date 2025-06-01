class CreateUploadedDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :uploaded_documents do |t|
      t.string :file
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
