class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :name
      t.integer :type
      t.string :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
