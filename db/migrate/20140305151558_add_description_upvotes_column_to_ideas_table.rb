class AddDescriptionUpvotesColumnToIdeasTable < ActiveRecord::Migration
  def change
  	add_column :ideas, :description, :string
  	add_column :ideas, :upvotes, :integer
  end
end
