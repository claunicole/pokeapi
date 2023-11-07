class Api::V1::PokemonsController < ApplicationController

    def index
        @pokemons = Pokemon.all
        render json: @pokemons
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.create pokemon_params
        if @pokemon.save
            render json: { message: 'Congratulations the Pokemon has been created successfully', pokemon: @pokemon },
                   status: :ok
          else
            render json: { errors: @pokemon.errors, status: 'failed' }, status: :unprocessable_entity
          end
    end

    def show
        render json: @pokemon
    end

    def edit
    end

    def update
        @pokemon.update pokemon_params
        if @pokemon.update pokemon_params
            render json: { message: 'Congratulations the Pokemon has been update successfully', pokemon: @pokemon },
                   status: :ok
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
        @pokemon = Pokemon.find(params[:id])
    end

    def pokemon_params
        params.require(:pokemon).permit(:name, :order, :base_experience, :height, :weight)
    end


end

