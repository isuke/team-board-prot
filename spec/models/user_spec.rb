require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:article_logs) }
  it { should respond_to(:teams_users) }
  it { should respond_to(:team_user) }
  it { should respond_to(:teams) }
  it { should respond_to(:participate) }
  it { should respond_to(:participate?) }
  it { should respond_to(:role) }
  it { should respond_to(:admin?) }
  it { should respond_to(:admin!) }
  it { should respond_to(:usual?) }
  it { should respond_to(:usual!) }
  it { should respond_to(:guest?) }
  it { should respond_to(:guest!) }

  it { should be_valid }

  context "when name" do
    context "is not present" do
      before { user.name = " " }
      it { should_not be_valid }
    end

    context "is too long" do
      before { user.name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  context "when email" do
    context "is not present" do
      before { user.email = " " }
      it { should_not be_valid }
    end

    context "format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com user@foo..bar]
        addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
    end

    context "format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end

    context "is already taken" do
      before do
        user_with_same_email = user.dup
        user_with_same_email.name = "other"
        user_with_same_email.email.upcase!
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

    context "with mixed case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it "should be saved as all lower-case" do
        user.email = mixed_case_email
        user.save
        expect(user.reload.email).to eq mixed_case_email.downcase
      end
    end
  end

  context "when password" do
    context "is not present" do
      let(:user) do
        FactoryGirl.build(:user,
                           password: " ",
                           password_confirmation: " ")
      end
      it { should_not be_valid }
    end

    context "doesn't match confirmation" do
      before { user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    context "is too short" do
      before { user.password = user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }

    context "with valid password" do
      let(:user_for_valid_password) { found_user.authenticate(user.password) }

      it { should eq user_for_valid_password }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "participate" do
    let(:team) { FactoryGirl.create(:team) }

    before do
      user.save!
      user.participate(team).save!
    end

    it "should be true" do
      expect(user.participate? team).to be_truthy
    end
  end

end
