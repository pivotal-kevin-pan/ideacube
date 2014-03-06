class AddCommentsTable < ActiveRecord::Migration
  def change
  	 add_column :comments, :user_id, :integer
  	 add_column :comments, :idea_id, :integer
  	 add_column :comments, :content, :text
  end
end
