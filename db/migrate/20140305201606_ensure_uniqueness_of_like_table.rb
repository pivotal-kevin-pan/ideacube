class EnsureUniquenessOfLikeTable < ActiveRecord::Migration
  def change
  	add_index :likes, [:user_id, :idea_id], unique: true
  end
end
