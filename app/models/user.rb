class User < ApplicationRecord
    # Note the plural: articles
    has_many :articles

    # Before a user is saved into the database, downcase the email (i.e., make it lowercase)
    # See: https://guides.rubyonrails.org/active_record_callbacks.html
    before_save { self.email = email.downcase }

    validates :username, presence: true, 
                uniqueness: { case_sensitive: false },
                length: {minimum: 3, maximum: 25 }

    # Note that apparently this isn't the best regex for validating email addresses.
    # However the best one is very, very long.
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true,
                length: { maximum: 105 },
                uniqueness: { case_senitive: false },
                format: { with: VALID_EMAIL_REGEX }


    has_secure_password

    # IMPORTANT: Because we are using the bcrypt gem, despite the fact that the 
    # attribute is called "password_digest", we can still simply refer to it as "password".
    # This is called a "virtual attribute."
    # E.g., in the Rails console we can do "user.password = "1234". bcrypt then
    # converts this into a hash digest, which is what is actually stored in the 
    # "password_digest" column.
end