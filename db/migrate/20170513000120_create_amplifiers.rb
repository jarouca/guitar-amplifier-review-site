class CreateAmplifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :amplifiers do |t|
      t.string :manufacturer, null: false
      t.string :model, null: false
      t.string :speaker
      t.string :tube_set
    end
  end
end
