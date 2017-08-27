class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.references :user, foreign_key: true
      t.references :library, foreign_key: true
      t.date :started_at, null: false
      t.date :ended_at, null: false
      t.string :place_name
      t.string :book_title, null: false
      t.string :isbn

      t.timestamps
    end
  end
end
