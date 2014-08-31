require 'nokogiri'

class Gpx

  attr_reader :points, :distance, :total_ascent, :total_descent

  def initialize(file)
    @file          = file
    @points        = []
    @distance      = 0
    @total_ascent  = 0
    @total_descent = 0
    parse_gpx
  end

  def calc_distance
    i = 0
    loop do
      a = [ @points[i][:lon].to_f, @points[i][:lat].to_f ]
      b = [ @points[i+1][:lon].to_f, @points[i+1][:lat].to_f ]
      @distance += distance_between_points(a, b)
      i += 1
      break if i >= @points.length - 2
    end
  end

  def calc_elevations
    i = 0
    loop do
      a = @points[i][:ele].to_f
      b = @points[i+1][:ele].to_f
      b > a ? @total_ascent += (b - a) : @total_descent += (a - b)
      i += 1
      break if i >= @points.length - 2
    end
  end

  def parse_gpx
    gpx   = Nokogiri::XML @file
    nodes = gpx.xpath('//xmlns:trkpt')

    nodes.each do |node|
      @points << {
        lon: node['lon'],
        lat: node['lat'],
        ele: get_elevation(node)
      }
    end
    calc_distance
    calc_elevations
  end

  def get_elevation(node)
    node.children.each do |child|
      return child.content if child.node_name == 'ele'
    end
  end

  # http://stackoverflow.com/questions/12966638/rails-how-to-calculate-the-distance-of-two-gps-coordinates-without-having-to-u
  def distance_between_points a, b
    rad_per_deg = Math::PI/180  # PI / 180
    rkm         = 6371          # Earth radius in kilometers
    rm          = rkm * 1000    # Radius in meters

    dlon_rad = (b[1]-a[1]) * rad_per_deg  # Delta, converted to rad
    dlat_rad = (b[0]-a[0]) * rad_per_deg

    lat1_rad, lon1_rad = a.map! {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = b.map! {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end

end
