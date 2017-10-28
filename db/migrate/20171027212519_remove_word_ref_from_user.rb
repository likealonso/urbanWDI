class RemoveWordRefFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :word, foreign_key: true
  end
end
