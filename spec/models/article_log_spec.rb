require 'rails_helper'

describe Article do
  let(:originator)  { FactoryGirl.create(:article) }
  let(:article_log) { originator.logs.first }

  subject { article_log }

  it { should be_valid }

  it { should     respond_to(:originator) }
  it { should     respond_to(:title) }
  it { should     respond_to(:content) }
  it { should     respond_to(:created_at) }
  it { should_not respond_to(:updated_at) }
  it { should     respond_to(:next) }
  it { should     respond_to(:prev) }
  it { should     respond_to(:user) }

  its(:originator) { should eq originator }
end

