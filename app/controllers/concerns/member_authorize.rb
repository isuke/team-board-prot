module MemberAuthorize
  extend ActiveSupport::Concern

  private

    def member_authorize(team_id, only: nil)
      @team = Team.find(team_id)
      if @team.users.include? current_user
        if only.present?
          if (only.respond_to?(:map) && !only.map(&:to_sym).include?(current_user.role(@team).to_sym)) ||
            (only.to_sym != current_user.role(@team).to_sym)
            flash[:danger] = "Sorry. You can not view this page."
            redirect_to team_path(@team)
          end
        end
      else
        flash[:danger] = "Sorry. You can not view this team's page."
        redirect_to root_path
      end
    end

end
