class AddUserIdToArticles < ActiveRecord::Migration[5.2]
  def change
    # Foreign key must be type integer
    add_column :articles, :user_id, :integer
  end
end
