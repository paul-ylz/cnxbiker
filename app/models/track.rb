class Track < ActiveRecord::Base
  belongs_to :route
  has_attached_file :gpx
  validates_attachment_content_type :gpx, :content_type => /application\/xml/
end
