require 'rails_helper'

describe "Article Pages" do
  subject { page }

  describe "index" do
    let!(:user1)    { FactoryGirl.create(:user) }
    let!(:user2)    { FactoryGirl.create(:user) }
    let!(:article1) { FactoryGirl.create(:article, user: user1) }
    let!(:article2) { FactoryGirl.create(:article, user: user2) }

    before do
      login user1
      visit articles_path
    end

    it { should have_title("Articles") }
    it { should have_link("Create Article") }
    it { should have_link(article1.title) }
    it { should have_link(article2.title) }
    it { should have_link("Delete") }
    it { should have_link("You")}
    it { should have_link(user2.name)}
    it { should have_selector("span", article1.comments.count) }
    it { should have_selector("span", article2.comments.count) }

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

    context "when click the user link" do
      before { click_link "You", match: :first }

      it { should have_title(user1.name) }
    end
  end

  describe "new" do
    let!(:user) { FactoryGirl.create(:user) }

    before do
      login user
      visit new_article_path
    end

    it { should have_title("New Article") }
    it { should have_button("Create") }
    it { should have_button("Preview") }

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

    context "when click the preview button" do
      let(:article_content) { "# Example Content" }

      before do
        fill_in "Content", with: article_content
        click_button "Preview"
      end

      it { should have_title("New Article") }
      it { should have_selector('h1', text: "Example Content") }
    end
  end

  describe "show" do
    let!(:user)    { FactoryGirl.create(:user) }
    let!(:article) { FactoryGirl.create(:article, user: user) }

    before do
      login user
      visit article_path article
    end

    it { should have_title(article.title) }
    it { should have_content(article.title) }
    it { should have_content(article.content) }
    it { should have_link("Edit") }
    it { should have_link("History") }
    it { should have_link("Show Logs") }
    it { should have_link("Delete") }
    it { should have_link("You") }

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

    describe "comments" do
      it { should have_content("Comments") }
      it { should have_button("Comment") }
      it { should have_content(article.comments.first.content) }

      context "when click the comment button" do
        before do
          fill_in "Content", with: "Test Comment"
        end

        it "should add comment" do
          expect{ click_button "Comment"}.to change(Comment, :count).by(1)
        end
      end
    end

  end

  describe "edit" do
    let!(:user)   { FactoryGirl.create(:user) }
    let(:article) { FactoryGirl.create(:article, user: user) }

    before do
      login user
      visit edit_article_path article
    end

    it { should have_title("#{article.title} Edit") }
    it { should have_button("Save") }
    it { should have_button("Preview") }

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

    context "when click the preview button" do
      let(:article_content) { "# Example Content" }

      before do
        fill_in "Content", with: article_content
        click_button "Preview"
      end

      it { should have_title("#{article.title} Edit") }
      it { should have_selector('h1', text: "Example Content") }
    end
  end

end
