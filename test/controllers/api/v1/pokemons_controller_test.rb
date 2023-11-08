require "test_helper"


class Api::V1::PokemonsControllerTest < ActionDispatch::IntegrationTest

  #TEST FOR POKEMON CRUD
  
  test 'valid_pokemon' do
    type = Type.create(name: 'grass')

    pokemon = Pokemon.new(name: 'Mew', order: 151, base_experience: 4, height: 4, weight:4, pokemon_types_attributes:[{slot: 1, type_id:type.id}] )
    assert pokemon.valid?, pokemon.errors.full_messages.to_sentence
  end

  test 'show_pokemon' do
    type = Type.create(name: 'grass')
    pokemon = Pokemon.create(name: 'Mew', order: 151, base_experience: 4, height: 4, weight: 4, pokemon_types_attributes: [{ slot: 1, type_id: type.id }])
  
    get api_v1_pokemon_path(pokemon) 
  
    assert_response :success
  
    json_response = JSON.parse(response.body)
    assert_equal pokemon.name, json_response['name']
    assert_equal pokemon.order, json_response['order']
    assert_equal pokemon.base_experience, json_response['base_experience']
    assert_equal pokemon.height, json_response['height']
    assert_equal pokemon.weight, json_response['weight']
    assert_equal 'grass', json_response['pokemon_types'].first['type']['name']
  end

  test 'update_pokemon' do
    type = Type.create(name: 'grass')
    pokemon = Pokemon.create(name: 'Mew', order: 151, base_experience: 4, height: 4, weight: 4, pokemon_types_attributes: [{ slot: 1, type_id: type.id }])
  
    updated_name = 'Mewtwo'
    updated_base_experience = 10
    patch api_v1_pokemon_path(pokemon), params: { pokemon: { name: updated_name, base_experience: updated_base_experience } }
  
    pokemon.reload
  
    assert_response :success
    assert_equal updated_name, pokemon.name
    assert_equal updated_base_experience, pokemon.base_experience
  end

  test 'delete_pokemon' do
    type = Type.create(name: 'grass')
    pokemon = Pokemon.create(name: 'Mew', order: 151, base_experience: 4, height: 4, weight: 4, pokemon_types_attributes: [{ slot: 1, type_id: type.id }])
  
    assert Pokemon.exists?(pokemon.id)
  
    delete api_v1_pokemon_path(pokemon)
  
    assert_response :success
  
    refute Pokemon.exists?(pokemon.id)
  end
end
  