require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Header" do
    before { visit home_path }

    it { should have_link('Top') }

    context "when un-login user" do
      it { should     have_link('Log in') }
      it { should_not have_link('Log out') }
    end

    context "when login user" do
      let!(:user) { FactoryGirl.create(:user) }
      before { login user }

      it { should_not have_link('Log in') }
      it { should     have_link('Log out') }
      it { should     have_link(user.name)}
    end

    describe "whe click the Log out button" do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        login user
        click_link "Log out"
      end

      it { should have_title 'Team Board Prototype' }
      it { should have_link('Log in') }

    end
  end

  describe "Home page" do
    let!(:signup) { "Sign up now!" }

    before { visit home_path }

    it { should have_title('Team Board Prototype') }

    context "when un-login user" do
      it { should have_link(signup) }
    end

    context "when login user" do
      let!(:user) { FactoryGirl.create(:user) }
      before { login user }
      it { should_not have_link(signup) }
    end
  end
end
