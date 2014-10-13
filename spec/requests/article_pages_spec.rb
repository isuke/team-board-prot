require 'rails_helper'

describe "Article Pages" do
  subject { page }

  describe "index" do

    let!(:article1) { FactoryGirl.create(:article) }
    let!(:article2) { FactoryGirl.create(:article) }

    before { visit articles_path }

    it { should have_title("Articles") }
    it { should have_link("Create Article") }
    it { should have_link(article1.title) }
    it { should have_link(article2.title) }
    it { should have_link("Delete") }


    context "when click the Create Article link" do
      before { click_link("Create Article") }

      it { should have_title("New Article") }
    end

    context "when click the article link" do
      before { click_link(article1.title) }

      it { should have_title(article1.title) }
    end

    context "when click the Delete link" do
      it "should delete the article" do
        expect{ click_link "Delete", match: :first }.to change(Article, :count).by(-1)
      end
    end
  end

  describe "new" do
    before { visit new_article_path }

    it { should have_title("New Article") }
    it { should have_button("Create") }

    context "when click the save button" do
      let(:article_title)   { "Example Title" }
      let(:article_content) { "# Example Content" }

      before do
        fill_in "Title"  , with: article_title
        fill_in "Content", with: article_content
      end

      it "should create a article" do
        expect{ click_button "Create" }.to change(Article, :count).by(1)
      end

      context "after saving the article" do
        before { click_button "Create" }

        it { should have_title(article_title) }
      end
    end
  end

  describe "show" do
    let!(:article) { FactoryGirl.create(:article) }

    before { visit article_path article }

    it { should have_title(article.title) }
    it { should have_content(article.title) }
    it { should have_content(article.content) }
    it { should have_link("Edit") }
    it { should have_link("History") }
    it { should have_link("Show Logs") }
    it { should have_link("Delete") }

    context "when click the Edit link" do
      before { click_link "Edit" }

      it { should have_title(article.title) }
    end

    context "when click the History link" do
      before { click_link "History" }

      it { should have_title "vs" }
    end

    context "when click the Show Logs link" do
      before { click_link "Show Logs" }

      it { should have_title("Article Logs") }
    end

    context "when click the Delete link" do
      it "should delete the article" do
        expect{ click_link "Delete" }.to change(Article, :count).by(-1)
      end
    end

  end

  describe "edit" do
    let(:article) { FactoryGirl.create(:article) }

    before { visit edit_article_path article }

    it { should have_title(article.title) }
    it { should have_button("Save") }

    context "when the save button click" do
      let(:article_title)   { "Example Title" }
      let(:article_content) { "Example Content" }

      before do
        fill_in "Title"  , with: article_title
        fill_in "Content", with: article_content
      end

      it "should save the article" do
        expect do
          click_button "Save"
        end.to change(ArticleLog, :count).by(1)
      end

      context "after save the article" do
        before { click_button "Save" }

        it { should have_title(article_title) }
        it { should have_content(article_content) }
      end
    end

  end
end
