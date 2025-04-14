# frozen_string_literal: true

module Types
  # Define os possíveis papéis (roles) de um Pokémon em batalha.
  module PokemonRole
    PHYSICAL_SWEEPER = :physical_sweeper
    SPECIAL_SWEEPER = :special_sweeper
    PHYSICAL_TANK = :physical_tank
    SPECIAL_TANK = :special_tank
    GENERAL = :general

    ALL = [
      PHYSICAL_SWEEPER,
      SPECIAL_SWEEPER,
      PHYSICAL_TANK,
      SPECIAL_TANK,
      GENERAL
    ].freeze

    # Mapeamento de roles para os atributos de ordenação prioritários
    SORT_ATTRIBUTES = {
      PHYSICAL_SWEEPER => %i[defense hp special_defense],
      SPECIAL_SWEEPER => %i[special_defense hp defense],
      PHYSICAL_TANK => %i[attack speed hp],
      SPECIAL_TANK => %i[special_attack speed hp],
      GENERAL => %i[attack special_attack speed]
    }.freeze

    def self.identify(pokemon)
      # Define um threshold para determinar se as estatísticas são balanceadas
      threshold = 10

      # Calcula a média das estatísticas principais
      stats = [pokemon.hp, pokemon.attack, pokemon.special_attack, pokemon.defense, pokemon.special_defense,
               pokemon.speed]
      avg_stats = stats.sum.to_f / stats.size

      # Verifica se as estatísticas estão dentro do threshold da média (estatísticas balanceadas)
      balanced = stats.all? { |stat| (stat - avg_stats).abs <= threshold }

      # Se as estatísticas forem balanceadas, retorna GENERAL
      return GENERAL if balanced

      # Caso contrário, identifica a role baseada nas duas maiores estatísticas
      top_two = stats.max(2)

      if top_two.include?(pokemon.attack) && top_two.include?(pokemon.speed)
        PHYSICAL_SWEEPER
      elsif top_two.include?(pokemon.special_attack) && top_two.include?(pokemon.speed)
        SPECIAL_SWEEPER
      elsif top_two.include?(pokemon.attack) && top_two.include?(pokemon.defense)
        PHYSICAL_TANK
      elsif top_two.include?(pokemon.special_attack) && top_two.include?(pokemon.special_defense)
        SPECIAL_TANK
      else
        GENERAL
      end
    end
  end
end
