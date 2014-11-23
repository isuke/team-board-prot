class TeamsUsersController < ApplicationController
  include MemberAuthorize
  before_action -> { @team = Team.find(params[:team_id]) }
  before_action -> { member_authorize @team, only: :admin }

  def index
  end

  def create
    emails = params[:emails].split /\s*,\s*/

    @messages = {success: [], danger: []}
    emails.each do |email|
      if user = User.find_by(email: email)
        if @team.member? user
          @messages[:danger] << "#{email} : This email's user is already #{@team.name}'s member."
        elsif @team.add_member(user, role: :usual).save
            @messages[:success] << "#{email} : success"
        else
          @messages[:danger] << "#{email} : Unkown error."
        end
      else
        @messages[:danger] << "#{email} : Do not found this email's user."
      end
    end
    render 'index'
  end

  def destroy
    user = User.find(params[:user_id])
    @team.remove_member(user)
    flash[:success] = "Remove '#{user.name}'."
    render 'index'
  end
end
