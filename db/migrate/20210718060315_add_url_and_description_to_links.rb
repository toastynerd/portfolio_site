class AddUrlAndDescriptionToLinks < ActiveRecord::Migration[6.1]
  def change
    remove_column :links, :body
    add_column :links, :url, :string
    add_column :links, :description, :string
  end
end
