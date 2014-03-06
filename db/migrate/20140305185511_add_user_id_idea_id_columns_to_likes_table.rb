class AddUserIdIdeaIdColumnsToLikesTable < ActiveRecord::Migration
  def change
  	add_column :likes, :user_id, :integer
  	add_column :likes, :idea_id, :integer
  end
end
