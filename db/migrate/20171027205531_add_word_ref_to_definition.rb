class AddWordRefToDefinition < ActiveRecord::Migration[5.1]
  def change
    remove_column :words, :definition_id
  end
end
