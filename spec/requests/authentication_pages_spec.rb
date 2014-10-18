require 'rails_helper'

describe "Authentication" do

  subject{ page }

  describe "login page" do
    before { visit login_path }

    it { should have_title('Log in') }
    it { should have_button('Log in') }

    context "with invalid information" do
      before { click_button('Log in') }

      it { should have_title('Log in') }
      it { should have_selector('div.alert.alert-danger', 'Invalid') }
    end

    context "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email"   , with: user.email.upcase
        fill_in "Password", with: user.password
        click_button('Log in')
      end

      it { should have_title("Articles") }
      it { should_not have_button('Log in') }
    end
  end
end
