class Track < ActiveRecord::Base
  belongs_to :route
  has_attached_file :gpx
  validates_attachment_file_name :gpx, :matches => [/gpx\Z/]

  def process_gpx
    gpx = Gpx.new self.gpx.path
    self.update_attributes distance: gpx.distance,
                           total_ascent: gpx.total_ascent,
                           total_descent: gpx.total_descent
  end
end
