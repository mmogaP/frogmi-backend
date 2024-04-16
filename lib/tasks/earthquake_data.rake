# lib/tasks/fetch_earthquake_data.rake
namespace :earthquake do
  desc 'Obtener datos de terremotos y almacenarlos en la base de datos'
  task fetch: :environment do
  response = HTTParty.get('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
  features = response.parsed_response['features']

    features.each do |feature|
      properties = feature['properties']
      geometry = feature['geometry']

      Earthquake.find_or_create_by(external_id: feature['id']) do |earthquake|
        earthquake.magnitude = properties['mag']
        earthquake.place = properties['place']
        earthquake.time = Time.at(properties['time'] / 1000)
        earthquake.url = properties['url']
        earthquake.tsunami = properties['tsunami'] == 1
        earthquake.magType = properties['magType']
        earthquake.title = properties['title']
        earthquake.longitude = geometry['coordinates'][0]
        earthquake.latitude = geometry['coordinates'][1]
      end
    end
  end
end
