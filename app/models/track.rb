class Track < ActiveRecord::Base
  belongs_to :route
  has_attached_file :gpx
  validates_attachment_file_name :gpx, :matches => [/gpx\Z/]
end
