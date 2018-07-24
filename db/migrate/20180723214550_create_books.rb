class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :courses
      t.boolean :sold
      t.string :price
      t.timestamps
    end
  end
end
