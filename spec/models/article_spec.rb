require 'rails_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }

  subject { article }

  it { should be_valid }

  it { should respond_to(:logs) }
  it { should respond_to(:latest_log) }

  its(:title)   { should eq article.latest_log.title }
  its(:content) { should eq article.latest_log.content }

end
