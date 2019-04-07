# Enforce validations in the model layer to mantain data integrity.

# NOTE: If you are making CRUD operations from the Rails console, you must
# run "reload!" in the console after making changes to this file.

class Article < ApplicationRecord
    # Note the singular: user
    belongs_to :user

    # Ensures that before an entry can hit the articles database, it must have a title.
    # I.e., the title attribute cannot be nil.
        
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    validates :user_id, presence: true

end