class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change

    # The "default: false" part makes it so that the default value is false (as opposed to nil).
    add_column :users, :admin, :boolean, default: false


  end
end
