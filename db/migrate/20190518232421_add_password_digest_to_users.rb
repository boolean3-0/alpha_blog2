# Note that the field must be called "password_digest" if you are using the bcrypt gem.
# Search the "has_secure_password" method on the Rails API for more details.

class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
  end
end
