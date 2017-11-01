class Word < ApplicationRecord
  belongs_to :user
  has_many :definitions, dependent: :destroy
  accepts_nested_attributes_for :definitions
  validates_presence_of :name
end
