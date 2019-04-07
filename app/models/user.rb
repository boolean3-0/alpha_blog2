class User < ApplicationRecord

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

end