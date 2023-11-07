class Api::V1::TypesController < ApplicationController

    before_action :set_type, only: [:show, :update, :destroy]
    
    def index
        @types = Type.all
        render json: @types
    end

    def show
        render json: @type
      end
    
      def create
        @type = Type.new(type_params)
        if @type.save
          render json: @type, status: :created
        else
          render json: @type.errors, status: :unprocessable_entity
        end
      end
    
      def update
        if @type.update(type_params)
          render json: @type
        else
          render json: @type.errors, status: :unprocessable_entity
        end
      end
    
      def destroy
        @type.destroy
        render json: { message: 'Type was successfully deleted.' }
      end
    
      private
    
      def set_type
        @type = Type.find(params[:id])
      end
    
      def type_params
        params.require(:type).permit(:name)
      end
end