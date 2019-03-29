class AddDescriptionToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :description, :text

    # For the following methods, the names must be "created_at" and
    # "updated_at" for Rails to track them.
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
  end
end
