class PokemonType < ApplicationRecord
  #INTERMEDIATE MODEL FOR RELATIONS BETWEEN POKEMON AND TYPE
  belongs_to :pokemon
  belongs_to :type

  accepts_nested_attributes_for :type
  validates :slot, uniqueness: { scope: :pokemon_id }
  

end
