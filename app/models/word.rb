class Word < ApplicationRecord
  belongs_to :user
  has_many :definitions

  accepts_nested_attributes_for :definitions
  # def self.search(name)
  #   if name
  #     find(:all, :conditions => ['name LIKE ?', "%#{name}%"])
  #   else
  #     find(:all)
  #   end
  # end

  # def self.search(name)
  #   where("name LIKE ?", "%#{name}%") 
  # end
end
