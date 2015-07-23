class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.integer :http_response
      t.belongs_to :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
