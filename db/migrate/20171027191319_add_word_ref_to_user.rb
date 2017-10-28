class AddWordRefToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :word, foreign_key: true
  end
end
