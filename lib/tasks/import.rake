require 'json'
require 'net/http'
require 'uri'

namespace :import do
    desc "Import data from PokeApi"
    task import_pokemon: :environment do 
        url = URI.parse('https://pokeapi.co/api/v2/pokemon/?limit=20')
        response = Net::HTTP.get_response(url)
        
        data = JSON.parse(response.body)["results"]
        
        data.each do |pokemon|
            pokemon_url = URI.parse(pokemon['url'])
            detail_response = Net::HTTP.get_response(pokemon_url)

            detail_data = JSON.parse(detail_response.body)

            new_pokemon = Pokemon.create(
                name: detail_data['name'],
                order: detail_data['order'],
                base_experience: detail_data['base_experience'],
                height: detail_data['height'],
                weight: detail_data['weight'],
          )

          detail_data['types'].each do |type_entry|
            type_name = type_entry['type']['name']
            slot = type_entry['slot'] 
            type = Type.find_or_create_by!(name: type_name)
            new_pokemon.pokemon_types.create!(type: type, slot: slot)
          end
        end     
    end
  end