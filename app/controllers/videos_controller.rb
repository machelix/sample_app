class VideosController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :create]
  before_action :admin_user,     only: [:destroy]

  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264"]
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create!(video_params)
    redirect_to :action => :show, :id => @video.id
  end

  private

  def video_params
    params.require(:video).permit(:panda_video_id,:title)
  end
end