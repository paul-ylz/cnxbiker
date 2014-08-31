require 'nokogiri'

class Gpx

  def initialize(file)
    @file = file
    @points = []
    parse_gpx
  end

  def distance
    # Gives distance in m
    # accumulate and calculate the distances between each set of lat/long in the array
  end

  def total_ascent
    # Gives total ascent in m
    # compare elevations sequentially. if the 2nd is larger, add the difference
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
  end

  def get_elevation(node)
    node.children.each do |child|
      return child.content if child.node_name == 'ele'
    end
  end
end
