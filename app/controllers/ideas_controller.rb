class IdeasController < ApplicationController
	def new
		@idea = current_user.ideas.new
	end

	def create
		@idea = current_user.ideas.build(idea_params)

		if @idea.save
			redirect_to ideas_path
		else
			render 'new'
		end
	end

	def index
		@ideas = Idea.all.paginate(page: params[:page], :per_page => 5, order: "created_at DESC")
	end

	def show
		@idea = Idea.find(params[:id])
		@comments = @idea.comments.order("created_at DESC")
		# @comments = @idea.comments.paginate(page: params[:page], :per_page => 5, order: "created_at DESC")
	end

	private
		def idea_params
			params.require(:idea).permit(:title, :description)
		end
end
