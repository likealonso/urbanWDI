class User < ApplicationRecord
    has_many :words
    has_many :definitions
    has_secure_password
    validates :email, presence: true, uniqueness: true, length: { minimum: 11 }
    validates :password, length: { minimum: 4 }
end
