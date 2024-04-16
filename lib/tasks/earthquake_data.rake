# lib/tasks/fetch_earthquake_data.rake
namespace :earthquake do
  desc 'Obtener datos de terremotos y almacenarlos en la base de datos'
  task fetch: :environment do
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    data['features'].each do |feature|
      properties = feature['properties']
      coordinates = feature['geometry']['coordinates']

      Earthquake.create(
        external_id: feature['id'],
        magnitude: properties['mag'],
        place: properties['place'],
        time: Time.at(properties['time'] / 1000), # Convert UNIX timestamp to Ruby Time object
        external_url: properties['url'],
        tsunami: properties['tsunami'],
        mag_type: properties['magType'],
        title: properties['title'],
        longitude: coordinates[0],
        latitude: coordinates[1]
      )
    end

    puts 'Earthquake data fetched and persisted successfully!'
  end
end
