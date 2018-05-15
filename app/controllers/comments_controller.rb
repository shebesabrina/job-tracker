class CommentsController < ApplicationController

  def index
    @job = Job.find(params[:job_id])
    @comments = @job.comments
  end

  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.create(comment_params)
    # require 'pry'; binding.pry
    redirect_to job_path(@job)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
