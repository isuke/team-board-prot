class TeamsController < ApplicationController
  before_action :member_authorize, only: :show

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

    def member_authorize
      unless Team.find(params[:id]).users.include? current_user
        flash[:danger] = "Sorry. You can not view this team's page."
        redirect_to root_path
      end
    end


end

