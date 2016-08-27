class Bench < ActiveRecord::Base
  validates :lat, :lng, presence: true

  def self.in_bounds(bounds)
    upper_lat_bound = bounds["northEast"]["lat"].to_f
    lower_lat_bound = bounds["southWest"]["lat"].to_f
    upper_lng_bound = bounds["northEast"]["lng"].to_f
    lower_lng_bound = bounds["southWest"]["lng"].to_f

    self.all.select do |bench|
      bench.lat.between?(lower_lat_bound, upper_lat_bound) &&
      bench.lng.between?(lower_lng_bound, upper_lng_bound)
    end
  end
end
