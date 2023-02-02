class User < ApplicationRecord
    has_secure_password
    
    has_many :posts
    has_many :likes
    has_many :comments
    has_many :user_communities
    has_many :communities, through: :user_communities



    validates :email, presence: true, uniqueness: true, format: { with:
    URI::MailTo::EMAIL_REGEXP }

    PASSWORD_REQUIREMENTS = /\A
    (?=.{8,})
    (?=.*\d)
    (?=.*[a-z])
    (?=.*[A-Z])
    (?=.*[[:^alnum:]])
/x

    validates :password, format: PASSWORD_REQUIREMENTS
    validates :username, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
