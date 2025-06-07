class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :inn
      t.string :name
      t.text :contact_info

      t.timestamps
    end
    add_index :companies, :inn, unique: true
  end
end
