class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :content
      t.boolean :status
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
