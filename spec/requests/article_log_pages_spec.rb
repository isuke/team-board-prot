require 'rails_helper'

describe "Article Log Pages" do
  subject { page }

  describe "index" do
    let!(:user)         { FactoryGirl.create(:user) }
    let!(:article)      { FactoryGirl.create(:article, user: user) }
    let!(:article_log1) { article.logs[0] }
    let!(:article_log2) { article.logs[1] }
    let!(:article_log3) { article.logs[2] }

    before do
      login user
      visit article_logs_path article
    end

    it { should have_title("Article Logs") }
    it { should have_content("Article Logs") }
    it { should have_link(article_log1.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }
    it { should have_link(article_log2.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }
    it { should have_link(article_log3.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }
    it { should have_button("Diff") }

    context "when click the Create Article link" do
      before { click_link(article_log2.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }

      it { should have_title(article_log2.title) }
    end

    context "when click the Diff button" do
      before { click_button("Diff") }

      it { should have_title("vs") }
    end

  end


  describe "show" do
    let!(:user)        { FactoryGirl.create(:user) }
    let!(:article_log) { FactoryGirl.create(:article, user: user).latest_log }

    before do
      login user
      visit article_log_path(article_log)
    end

    it { should have_title(article_log.title) }
    it { should have_content(article_log.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')) }
    it { should have_link("You") }
    it { should have_link("History") }

    context "when click the History button" do
      before { click_link("History") }

      it { should have_title("vs") }
    end
  end

  describe "diff" do
    let!(:user)    { FactoryGirl.create(:user) }
    let!(:article) { FactoryGirl.create(:article, user: user) }
    let!(:left_article_log)  { article.logs[0] }
    let!(:right_article_log) { article.logs[1] }

    before do
      login user
      visit diff_articles_path(left_article_log, right_article_log)
    end

    it do
      should have_title("#{left_article_log.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')} vs #{right_article_log.created_at.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')}")
    end

    it { should have_content left_article_log.title }
    it { should have_content right_article_log.title }
  end
end
