class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :publisher
      t.date :date_published
      t.decimal :unit_cost, :precision => 6, :scale => 2
      t.string :category

      t.timestamps
    end
  end
end
