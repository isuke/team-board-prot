require 'rails_helper'

describe Article do
  let(:article)     { FactoryGirl.create(:article) }
  let(:article_log) { FactoryGirl.build(:article_log, article_id: article.id) }

  subject { article_log }

  it { should be_valid}

  it { should     respond_to(:article) }
  it { should     respond_to(:title) }
  it { should     respond_to(:content) }
  it { should     respond_to(:created_at) }
  it { should_not respond_to(:updated_at) }

  its(:article) { should eq article }
end

