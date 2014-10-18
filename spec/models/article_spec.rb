require 'rails_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }

  subject { article }

  it { should be_valid }

  it { should respond_to(:logs) }
  it { should respond_to(:latest_log) }
  it { should respond_to(:create_user) }
  it { should respond_to(:edit_users) }
  it { should respond_to(:user) }

  its(:title)   { should eq article.latest_log.title }
  its(:content) { should eq article.latest_log.content }
  its(:create_user) { should eq article.oldest_log.user }

  context "when deleted" do
    let!(:logs_count) { article.logs.count }

    it "should delete its logs" do
      expect{ article.destroy }.to change(ArticleLog, :count).by(-logs_count)
    end
  end

end
