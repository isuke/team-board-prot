module MemberAuthorize
  extend ActiveSupport::Concern

  private

    def member_authorize(team, only: nil, expect: nil)
      if team.users.include? current_user
        current_user_role = current_user.role(team).to_sym
        if (  only.present? && (  only.respond_to?(:map) ?   !only.map(&:to_sym).include?(current_user_role) :   only.to_sym != current_user_role)) ||
           (expect.present? && (expect.respond_to?(:map) ?  expect.map(&:to_sym).include?(current_user_role) : expect.to_sym == current_user_role))
          flash[:danger] = "Sorry. You don't have permission of this action."
          redirect_to team_path(team)
        end
      else
        flash[:danger] = "Sorry. You can not view this team's page."
        redirect_to root_path
      end
    end

end
