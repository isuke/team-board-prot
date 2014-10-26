class TeamsUsersController < ApplicationController
  def create
    team = Team.find(params[:team_id])
    user = User.find(params[:user_id])
    user.participate(team).save
    redirect_to teams_path
  end

  def destroy
    TeamsUser.find_by(team_id: params[:team_id],
                      user_id: params[:user_id]).destroy
    redirect_to teams_path
  end
end
