class ApplicationController < ActionController::Base
end


# def index

#     if params[:type].present? # poison / grass
#         typea = params[:type][0] # poison
#         typeb = params[:type][1] # grass
#         type_list_a = Type.where(double_damage_from: typea).first # ground
#         type_list_b = Type.where(double_damage_from: typeb).first # fire
#         pokemon_list_a = Pokemon.where(type: type_list_a).order.average_stats.asc.limit(10) unless type_list_a.nil?
#         pokemon_list_b = Pokemon.where(type: type_list_b).order.average_stats.asc.limit(10) unless type_list_b.nil?
#         render json: [pokemon_list_a, pokemon_list_b]
#     elsif pokemon_list_a.nil? and pokemon_list_b.nil?
#         type_list_a = Type.where(half_damage_to: params[:type]).first # ghost
#         type_list_b = Type.where(half_damage_to: params[:type]).first # fire
#         pokemon_list_a = Pokemon.where(type: type).order.average_stats.asc.limit(10) unless type_list_a.nil?
#         pokemon_list_b = Pokemon.where(type: type).order.average_stats.asc.limit(10) unless type_list_b.nil?
#         render json: [pokemon_list_a, pokemon_list_b]
#     elsif pokemon.nil?
#         type_list_a = Type.where(no_damage_to: params[:type]).first # steel
#         type_list_b = Type.where(no_damage_to: params[:type]).first # nil
#         pokemon_list_a = Pokemon.where(type: type).order.average_stats.asc.limit(10) unless type_list_a.nil?
#         pokemon_list_b = Pokemon.where(type: type).order.average_stats.asc.limit(10) unless type_list_b.nil?
#         render json: [pokemon_list_a, pokemon_list_b]
#     else
#         pokemon = Pokemon.order.average_stats.asc.limit(10) # lista de pokemon com stats mais altas sem filtrar tipos
#         render json: pokemon
#     end

# end