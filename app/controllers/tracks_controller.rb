class TracksController < ApplicationController
  def download
    track = Track.find params[:id]
    send_file track.gpx.path
  end
end
