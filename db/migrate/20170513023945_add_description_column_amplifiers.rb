class AddDescriptionColumnAmplifiers < ActiveRecord::Migration[5.0]
  def change
    add_column :amplifiers, :description, :string
  end
end
