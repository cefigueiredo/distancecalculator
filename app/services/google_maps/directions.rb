module GoogleMaps
  class Directions
    include HTTParty

    attr_reader :options

    GOOGLE_DIRECTIONS_POINTS_LIMIT = 9

    base_uri 'https://maps.googleapis.com/maps/api/directions/json'

    def initialize
      @base_options = { key: ENV['GOOGLE_API_KEY'] }
    end

    def get_batched_directions(positions)
      path_polylines = []
      total_distance = 0

      last_destination = nil
      positions.each_slice(GOOGLE_DIRECTIONS_POINTS_LIMIT) do |slice|
        origin = last_destination || slice.first
        destination = slice.last
        waypoints = slice[0..-2]

        directions = get_directions(origin, destination, waypoints)
        directions['routes'].each do |route|
          path_polylines << route['overview_polyline']['points']
          route['legs'].each do |leg|
            total_distance += leg['distance']['value']
          end
        end

        last_destination = destination
      end

      {paths: path_polylines, total_distance: total_distance}
    end

    private

    def get_directions(origin, destination, waypoints)
      query = {
        origin: "#{origin['lat']},#{origin['lng']}",
        destination: "#{destination['lat']},#{destination['lng']}",
        departure_time: origin['time'],
        units: 'metric'
      }

      unless waypoints.empty?
        query[:waypoints] = waypoints.map do |point|
          "#{point['lat']},#{point['lng']}"
        end.join('|')
      end

      self.class.get('', @base_options.merge(query: query))
    end
  end
end
