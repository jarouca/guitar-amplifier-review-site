class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :review_id, null: false, foreign_key: true
      t.integer :user_id, null: false, foreign_key: true
      t.boolean :up_vote, default: true
    end
  end
end
