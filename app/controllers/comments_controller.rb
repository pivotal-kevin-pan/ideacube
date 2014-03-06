class CommentsController < ApplicationController
	def create
		@comment = current_user.comments.build(comment_params)

		@comment.user_id = current_user.id

		if @comment.save
			redirect_to idea_path(Idea.find(params[:comment][:idea_id]))
		else
			render 'new'
		end
	end
	private
		def comment_params
			params.require(:comment).permit(:idea_id, :content)
		end
end
