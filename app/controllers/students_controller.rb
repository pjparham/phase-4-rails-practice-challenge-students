class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student
        else
            render json: { error: "Student not found" }, status: :not_found
        end
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            render json: {errors: ["validations errors"] }, status: :unprocessable_entity
        end
    end

    def destroy 
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json: { error: "Student not found" }, status: :not_found
        end
    end

    def update
        student = Student.find_by(id: params[:id])
        if student
            student.update(student_params)
            if student.valid?
                render json: student, status: :accepted
            else
                render json: {errors: ["validations errors"] }, status: :unprocessable_entity
            end
        else
            render json: { error: "Student not found" }, status: :not_found
        end
    end

    private 

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
      end
end
