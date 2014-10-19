require 'rails_helper'

describe "Team Pages" do
  subject { page }

  describe "index" do
    let!(:user)       { FactoryGirl.create(:user) }
    let!(:team)       { FactoryGirl.create(:team) }
    let!(:other_team) { FactoryGirl.create(:team) }
    let(:submit) { "Create new team" }

    before do
      FactoryGirl.create(:teams_user, team: team, user: user)
      login user
      visit teams_path
    end

    it { should have_title("Teams") }
    it { should have_content(team.name) }
    it { should have_link("Leave") }
    it { should have_link("Participate") }
    it { should have_button(submit) }

    context "when click create button" do
      let(:team_name)   { "Example Team" }

      before { fill_in "Name", with: team_name }

      it "should create a team" do
        expect{ click_button submit }.to change(Team, :count).by(1)
      end
    end

    context "when click a Leave link" do
      it "should delete relationship" do
        expect do
          click_link "Leave", match: :first
        end.to change(TeamsUser, :count).by(-1)
      end
    end

    context "when click a Participate link" do
      it "should create relationship" do
        expect do
          click_link "Participate", match: :first
        end.to change(TeamsUser, :count).by(1)
      end
    end
  end

  describe "show" do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:team)  { FactoryGirl.create(:team) }

    before do
      FactoryGirl.create(:teams_user, team: team, user: user1)
      FactoryGirl.create(:teams_user, team: team, user: user2)
      login user1
      visit team_path(team)
    end

    it { should have_title(team.name) }
    it { should have_content(team.name) }
    it { should have_content("You") }
    it { should have_content(user1.email) }
    it { should have_content(user2.name) }
    it { should have_content(user2.email) }

  end

end
