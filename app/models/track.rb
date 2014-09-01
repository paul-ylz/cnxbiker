class Track < ActiveRecord::Base
  belongs_to :route
  has_attached_file :gpx
  validates_attachment_file_name :gpx, :matches => [/gpx\Z/]

  def process_gpx
    gpx = Gpx.new self.gpx.path
    self.update_attributes distance: gpx.distance.round(1),
                           total_ascent: gpx.total_ascent.round,
                           total_descent: gpx.total_descent.round
  end
end
