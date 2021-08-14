class Api::V1::HomeController < ApplicationController
  def index
    types = Type.all
    # return only the types that have "bug" or "grass" on field double_damage_to
    types = types.select { |t| t.double_damage_to.include?("bug") and t.double_damage_to.include?("grass") }
    render json: types
  end
end