class EarthquakesController < ApplicationController
  def show
    earthquake = Earthquake.includes(:comments).find(params[:id])
    render json: earthquake.as_json(include: :comments)
  end
  def index
    earthquakes = Earthquake.all
    earthquakes = earthquakes.where(magType: params[:filters][:mag_type]) if params[:filters]&.[](:mag_type)
    @earthquakes = Earthquake.page(params[:page]).per(12)
    per_page = [params[:per_page].to_i, 1000].min

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