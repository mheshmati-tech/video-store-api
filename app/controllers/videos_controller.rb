class VideosController < ApplicationController
  def index
    videos = Video.all.order(:title)

    render json: videos.as_json(only: [:id, :title, :release_date, :available_inventory]), status: :ok
  end

  def show
    video = Video.find_by(id: params[:id])

    if video
      render json: video.as_json(only: [:title, :overview, :release_date, :total_inventory, :available_inventory])
      return
    else #### TODO -- Do we need to include the id or not? was not included in the index action but it is for the show action?
      
      render json: {
        errors: ["Not Found"],
      }, status: :not_found
      return
    end
  end

  def create
    video = Video.new(video_params)

    if video.save
      render json: video.as_json(only: [:id]), status: :created
      return
    else
      render json: {
        errors: video.errors.messages,
      }, status: :bad_request
      return
    end
  end

  private

  def video_params
    return params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end
