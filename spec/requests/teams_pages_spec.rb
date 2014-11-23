require 'rails_helper'

describe "Team" do
  subject { page }

  describe "index page" do
    let!(:user)       { FactoryGirl.create(:user) }
    let!(:team1)      { FactoryGirl.create(:team) }
    let!(:team2)      { FactoryGirl.create(:team) }
    let!(:other_team) { FactoryGirl.create(:team) }
    let(:submit) { "Create new team" }

    before do
      participate(team1, user, role: :admin)
      participate(team2, user, role: :usual)
      login user
      visit teams_path
    end

    it { should     have_title("Teams") }
    it { should     have_content(team1.name) }
    it { should     have_content("admin") }
    it { should     have_content(team2.name) }
    it { should     have_content("usual") }
    it { should_not have_content(other_team.name) }
    it { should     have_button(submit) }

    context "when click create button" do
      let(:team_name)   { "Example Team" }

      before { fill_in "Name", with: team_name }

      it "should create a team" do
        expect{ click_button submit }.to change(Team, :count).by(1)
      end

      context "after create a team" do
        let(:new_team) { Team.find_by!(name: "Example Team") }

        before { click_button submit }

        it "should create user's role is admin" do
          expect(user.admin?(new_team)).to be_truthy
        end
      end
    end

  end

  describe "show page" do
    let!(:user1)    { FactoryGirl.create(:user) }
    let!(:user2)    { FactoryGirl.create(:user) }
    let!(:team)     { FactoryGirl.create(:team) }
    let!(:article1) { FactoryGirl.create(:article, user: user1, team: team) }
    let!(:article2) { FactoryGirl.create(:article, user: user2, team: team) }

    before do
      participate(team, user1)
      participate(team, user2)
      login user1
      visit team_path(team)
    end

    it { should have_title(team.name) }
    it { should have_content(team.name) }

    describe "articles" do
      it { should have_content("You") }
      it { should have_content(user1.email) }
      it { should have_content(user2.name) }
      it { should have_content(user2.email) }
      it { should have_link("Create Article") }
      it { should have_link(article1.title) }
      it { should have_link(article2.title) }
      it { should have_link("Delete") }

      context "when click the Create Article link" do
        before { click_link("Create Article") }

        it { should have_title("New Article") }
      end

      context "when click the article link" do
        before { click_link(article1.title) }

        it { should have_title(article1.title) }
      end

      context "when click the Delete link" do
        it "should delete the article" do
          expect{ click_link "Delete", match: :first }.to change(Article, :count).by(-1)
        end
      end

    end

    describe "members" do
      it { should have_link("You")}
      it { should have_link(user2.name)}
      it { should have_selector("span", article1.comments.count) }
      it { should have_selector("span", article2.comments.count) }

      context "when click the user link" do
        before { click_link "You", match: :first }

        it { should have_title(user1.name) }
      end
    end
  end

end
