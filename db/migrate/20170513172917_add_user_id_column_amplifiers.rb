class AddUserIdColumnAmplifiers < ActiveRecord::Migration[5.0]
  def change
    add_column :amplifiers, :user_id, :integer
  end
end
