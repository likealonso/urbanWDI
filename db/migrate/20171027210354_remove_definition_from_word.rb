class RemoveDefinitionFromWord < ActiveRecord::Migration[5.1]
  def change
    remove_reference :words, :definition, foreign_key: true
  end
end
