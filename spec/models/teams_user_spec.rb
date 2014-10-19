require 'rails_helper'

describe "TeamsUser" do
  let(:team)       { FactoryGirl.create(:team) }
  let(:user)       { FactoryGirl.create(:user) }
  let(:teams_user) { FactoryGirl.create(:teams_user, team: team, user: user) }

  subject { teams_user }

  it { should be_valid }

  it { should respond_to(:team) }
  it { should respond_to(:user) }
end
