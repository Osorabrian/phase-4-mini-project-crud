class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :spice_not_found

    def index
        render json: Spice.all
    end

    def create
        spice = Spice.create(permitted_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(permitted_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end


    private

        def permitted_params
            params.permit(:title, :image, :description, :notes, :rating)
        end

        def find_spice
            Spice.find(params[:id])
        end

        def spice_not_found
            render json: {error: "Spice not found"}
        end
end
