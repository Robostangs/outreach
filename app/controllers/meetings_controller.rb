class MeetingsController < ApplicationController
	def index
		@meetings = Meeting.desc.paginate(:page => params[:page])
	end
  def show
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end
end
