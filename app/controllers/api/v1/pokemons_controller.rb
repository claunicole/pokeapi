class Api::V1::PokemonsController < ApplicationController
    before_action :set_pokemon, only: [:show, :update, :destroy]

    def index
        @pokemons = Pokemon.all.includes(:types)
        render json: @pokemons.as_json(include: { pokemon_types: { include: { type: { only: :name } }, only: :slot } })
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.create pokemon_params
        if @pokemon.save
            render json: {
                message: 'Congratulations the Pokemon has been created successfully',
                pokemon: @pokemon.as_json(include: {
                    pokemon_types: {
                        include: {
                            type: { only: :name }
                        },
                        only: [:id, :slot] 
                    }
                })
            }, status: :ok
          else
            render json: { errors: @pokemon.errors, status: 'failed' }, status: :unprocessable_entity
          end
    end

    def show
        render json: @pokemon.as_json(include: { pokemon_types: { include: { type: { only: :name } }, only: :slot } })
    end

    def edit
    end

    def update
        if @pokemon.update(pokemon_params)
            render json: {
                message: 'Congratulations the Pokemon has been updated successfully',
                pokemon: @pokemon.as_json(include: {
                    pokemon_types: {
                        include: {
                            type: { only: :name }
                        },
                        only: [:id, :slot] 
                    }
                })
            }, status: :ok
          else
            render json: { errors: @pokemon.errors, status: 'failed' }, status: :unprocessable_entity
          end
    end

    def destroy
        @pokemon.destroy
        render json: { message: 'Pokemon has been deleted successfully' }, status: :ok
    end

    private

    def set_pokemon
        @pokemon = Pokemon.includes(pokemon_types: :type).find(params[:id])
    end

    def pokemon_params
        params.require(:pokemon).permit(:name, :order, :base_experience, :height, :weight, pokemon_types_attributes: [:id, :slot, :type_id])
    end


end

