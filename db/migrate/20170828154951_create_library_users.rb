class CreateLibraryUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :library_users do |t|
      t.references :user, foreign_key: true
      t.references :library, foreign_key: true
      t.string :sign_in_id
      t.string :password
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :last_sign_in_at

      t.timestamps
    end
  end
end
