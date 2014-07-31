json.array!(@routes) do |route|
  json.extract! route, :id, :title, :description, :distance, :total_ascent
  json.url route_url(route, format: :json)
end
