class User < ApplicationRecord
    has_secure_password

    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify

    validates :email, email: true
    # bundle gem 'email_validator', '~> 2.2', '>= 2.2.3'
end
