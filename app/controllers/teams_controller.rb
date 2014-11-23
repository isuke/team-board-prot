class TeamsController < ApplicationController
  include MemberAuthorize
  before_action -> { @team = Team.find(params[:id]) }, only: :show
  before_action -> { member_authorize @team }, only: :show

  def index
    @teams = current_user.teams
    @team = Team.new
  end

  def show
  end

  def create
    ActiveRecord::Base.transaction do
      @team = Team.create(team_params)
      current_user.participate(@team, role: :admin).save!
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

