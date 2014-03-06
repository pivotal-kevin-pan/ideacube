class LikesController < ApplicationController
	 def create
	 	@form_id = params[:id_count]
	 	@like = Like.new(like_params)
	 	@like.save

	 	@idea = Idea.find(params[:idea_id])

	 	respond_to do |format|
	      format.js
	      format.html do
	      	@user = @idea.user
			@ideas = @user.ideas.paginate(page: params[:page], :per_page => 10, order: "created_at DESC")
	      	render template: "users/show"
	      end
	    end
	 end

	 def destroy
	 	@form_id = params[:id_count]
	 	like = Like.find(params[:id])
	 	like.destroy

	 	@idea = Idea.find(like.idea_id)

	 	respond_to do |format|
	      format.js
	      format.html do
	      	@user = @idea.user
			@ideas = @user.ideas.paginate(page: params[:page], :per_page => 10, order: "created_at DESC")
	      	render template: "users/show"
	      end
	    end
	 end

	 private
	 	def like_params
	 		return_params = ActionController::Parameters.new(
	 			idea_id: params[:idea_id],
				user_id: current_user.id
			)
			return_params.permit!
	 	end
end