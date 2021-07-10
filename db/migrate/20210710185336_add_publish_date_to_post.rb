class AddPublishDateToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :published, :date
  end
end
