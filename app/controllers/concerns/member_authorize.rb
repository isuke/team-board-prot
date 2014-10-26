module MemberAuthorize
  extend ActiveSupport::Concern

  private

    def member_authorize
      @team = Team.find(params[:team_id])
      unless @team.users.include? current_user
        flash[:danger] = "Sorry. You can not view this team's page."
        redirect_to root_path
      end
    end

end
