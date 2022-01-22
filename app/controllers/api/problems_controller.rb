class Api::ProblemsController < ApplicationController
  before_action :set_problem, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /api/problems.json
  def index
    @problems = Problem.includes(:topic_tags).all()
  end

  # GET /api/problems/1.json
  def show
  end

  # POST /api/problems.json
  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save
        format.json { render :show, status: :created, location: @problem }
      else
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.json { render :show, status: :ok, location: @problem }
      else
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/problems/1.json
  def destroy
    @problem.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def problem_params
      params.require(:problem).permit(:title, :difficulty, :description, :constraints)
    end
end
