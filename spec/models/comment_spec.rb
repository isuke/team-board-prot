require 'rails_helper'

describe Comment do
  let(:article) { FactoryGirl.create(:article) }
  let(:user)    { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment, article: article, user: user) }

  subject { comment }

  it { should be_valid }

  it { should respond_to(:article) }
  it { should respond_to(:user) }
  it { should respond_to(:content) }

  its(:article) { should eq comment.article }
  its(:user)    { should eq comment.user }
end
