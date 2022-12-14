class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor
        else
            render json: { error: "Instructor not found" }, status: :not_found
        end
    end

    def create
        instructor = Instructor.create(instructor_params)
        if instructor.valid?
            render json: instructor, status: :created
        else
            render json: {errors: ["validations errors"] }, status: :unprocessable_entity
        end
    end

    def destroy 
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            head :no_content
        else
            render json: { error: "Instructor not found" }, status: :not_found
        end
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.update(instructor_params)
            if instructor.valid?
                render json: instructor, status: :accepted
            else
                render json: {errors: ["validations errors"] }, status: :unprocessable_entity
            end
        else
            render json: { error: "Instructor not found" }, status: :not_found
        end
    end

    private 

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
      end
end
