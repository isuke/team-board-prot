require 'rails_helper'

describe "User pages" do

  subject { page }

  describe "sgin up" do
    before { visit signup_path }

    it { should have_title('Sign up') }

    let(:submit) { "Create my account" }

        context "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      context "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_selector('div.alert.alert-danger', text: 'error') }
      end
    end

    context "with valid information" do
      before do
        fill_in "Name"                 , with: "Example User"
        fill_in "Email"                , with: "user@example.com"
        fill_in "Password"             , with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before { click_button submit }

        it { should have_title('Articles') }
        it { should have_link('Log out') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "profile" do
    let(:user) { FactoryGirl.create(:user) }

    let(:delete) { "Delete my account" }

    before do
      login user
      visit user_path(user)
    end

    it { should have_title(user.name) }
    it { should have_content(user.name) }
    it { should have_content(user.email) }
    it { should have_link(delete) }

    context "when click a delete wall link" do
      it "should be able to delete the user" do
        expect do
          click_link(delete)
        end.to change(User, :count).by(-1)
      end
    end

  end
end
