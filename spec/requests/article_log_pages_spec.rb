require 'rails_helper'

describe "Article Log Pages" do
  subject { page }

  describe "index" do

    let!(:article)      { FactoryGirl.create(:article) }
    let!(:article_log1) { article.logs[0] }
    let!(:article_log2) { article.logs[1] }
    let!(:article_log3) { article.logs[2] }

    before { visit article_logs_path article }

    it { should have_title("Article Logs") }
    it { should have_content("Article Logs") }
    it { should have_link(article_log1.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }
    it { should have_link(article_log2.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }
    it { should have_link(article_log3.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }

    context "when click the Create Article link" do
      before { click_link(article_log2.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }

      it { should have_title(article_log2.title) }
    end

  end


  describe "show" do
    let!(:article_log) { FactoryGirl.create(:article_log) }

    before { visit article_log_path(article_log.article, article_log) }

    it { should have_title(article_log.title) }
    it { should have_content(article_log.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }

  end
end
