class Numeric
  def to_rad
    self * Math::PI / 180
  end
end

class Gpx
  attr_reader :points, :distance, :total_ascent, :total_descent

  def initialize(path)
    @coords        = []
    @elevations    = []
    @distance      = 0
    @total_ascent  = 0
    @total_descent = 0
    load_gpx path
  end

  def load_gpx(path)
    File.open(path) { |file| parse_gpx file }
  end

  def parse_gpx(file)
    gpx   = Nokogiri::XML file
    nodes = gpx.xpath('//xmlns:trkpt')

    nodes.each do |node|
      @coords << [ node['lat'].to_f, node['lon'].to_f ]

      node.children.each do |child|
        @elevations << child.content.to_f if child.node_name == 'ele'
      end
    end

    calc_distance
    calc_elevations
  end

  def calc_distance
    @distance = 0
    i         = 0

    loop do
      a = @coords[ i ]
      b = @coords[ i + 1 ]

      @distance += distance_between_points( a, b )

      i += 1
      break if i >= @coords.length - 2
    end
  end

  def calc_elevations
    @total_ascent, @total_descent = 0, 0
    i = 0
    loop do
      a = @elevations[ i ]
      b = @elevations[ i + 1 ]

      b > a ? @total_ascent += (b - a) : @total_descent += (a - b)
      i += 1
      break if i >= @elevations.length - 2
    end
  end

  # Haversine distance formula from https://gist.github.com/j05h/673425

  def distance_between_points(loc1, loc2)
     lat1, lon1 = loc1
     lat2, lon2 = loc2
     dLat       = (lat2 - lat1).to_rad
     dLon       = (lon2 - lon1).to_rad

     a = Math.sin(dLat/2) * Math.sin(dLat/2) +
         Math.cos(lat1.to_rad) * Math.cos(lat2.to_rad) *
         Math.sin(dLon/2) * Math.sin(dLon/2)

     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

     d = 6371 * c
  end
end
