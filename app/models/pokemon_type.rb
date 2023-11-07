class PokemonType < ApplicationRecord
  belongs_to :pokemon
  belongs_to :type

  accepts_nested_attributes_for :type
end
