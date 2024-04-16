class EarthquakesController < ApplicationController
  def index
    @earthquakes = Earthquake.page(params[:page]).per(10)

    render json: {
      data: @earthquakes.map do |earthquake|
        {
          id: earthquake.id,
          type: 'earthquake',
          attributes: {
            external_id: earthquake.external_id,
            magnitude: earthquake.magnitude,
            place: earthquake.place,
            time: earthquake.time,
            tsunami: earthquake.tsunami,
            mag_type: earthquake.mag_type,
            title: earthquake.title,
            coordinates: {
              longitude: earthquake.longitude,
              latitude: earthquake.latitude
            }
          },
          links: {
            external_url: earthquake.external_url
          }
        }
      end,
      pagination: {
        current_page: @earthquakes.current_page,
        total: @earthquakes.total_count,
        per_page: @earthquakes.limit_value
      }
    }
  end
end