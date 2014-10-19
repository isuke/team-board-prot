class TeamsController < ApplicationController

  def index
    @teams = Team.all
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    ActiveRecord::Base.transaction do
      @team = Team.create(team_params)
      current_user.participate(@team).save!
    end
    flash[:success] = "Create #{@team.name}."
    redirect_to teams_path
  rescue
    render 'index'
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end


end

