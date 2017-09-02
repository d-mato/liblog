class AddCrawlerToLibraries < ActiveRecord::Migration[5.1]
  def change
    add_column :libraries, :crawler, :string
  end
end
