module Services
  class PokemonService
    def find_counter(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)

      # TODO: logica para buscar counter

      return pokemon
    end
  end
end