require 'rails_helper'

describe "Team Users" do
  subject { page }

  describe "members pages" do

    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:team)  { FactoryGirl.create(:team) }
    let(:submit) { "Add Members"}

    before do
      participate(team, user1, role: :admin)
      participate(team, user2, role: :usual)
    end

    context "when admin user" do

      before do
        login user1
        visit members_path(team)
      end

      it { should have_title("members") }
      it { should have_content("#{team.name} Members") }

      describe "add members" do

        it { should have_button(submit) }

        context "when click add members button" do

          let(:other_user1) { FactoryGirl.create(:user) }
          let(:other_user2) { FactoryGirl.create(:user) }

          context "with correct emails" do
            before { fill_in "Emails", with: "#{other_user1.email}, #{other_user2.email}" }

            it "should add members" do
              expect{ click_button submit }.to change(TeamsUser, :count).by(2)
            end
          end
          context "with incorrect emails" do
            before do
              fill_in "Emails", with: "#{user1.email}, #{user2.email}, incorrent@example.com"
            end

            it "should add members" do
              expect{ click_button submit }.not_to change(TeamsUser, :count)
            end
          end
        end

      end

      describe "members" do

        it { should have_content("Members") }
        it { should have_link(user1.name) }
        it { should have_link(user2.name) }
        it { should have_link("Remove") }

        context "when click remove link" do
          it "should remove member" do
            expect{ click_link "Remove", match: :first }.to change(TeamsUser, :count).by(-1)
          end
        end

      end
    end

    context "when un-admin user" do

      before do
        login user2
        visit members_path(team)
      end

      it { should     have_title(team.name) }
      it { should_not have_title("members") }
      it { should     have_content(team.name) }

    end

  end
end
