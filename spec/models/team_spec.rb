require 'rails_helper'

describe "Team" do
  let(:team) { FactoryGirl.create(:team) }

  subject { team }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:teams_users) }
  it { should respond_to(:users) }
end
