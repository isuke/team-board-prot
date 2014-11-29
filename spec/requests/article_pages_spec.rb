require 'rails_helper'

describe "Article" do
  subject { page }

  describe "new page" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:team) { FactoryGirl.create(:team) }

    before do
      participate(team, user)
      login user
      visit new_article_path(team)
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

  describe "show page" do
    let!(:user)    { FactoryGirl.create(:user) }
    let!(:team)    { FactoryGirl.create(:team) }
    let!(:article) { FactoryGirl.create(:article, user: user, team: team) }

    before do
      participate(team, user, role: :admin)
      login user
      visit article_path team, article
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

  describe "edit page" do
    let!(:user)   { FactoryGirl.create(:user) }
    let!(:team)   { FactoryGirl.create(:team) }
    let(:article) { FactoryGirl.create(:article, user: user, team: team) }

    before do
      participate(team, user)
      login user
      visit edit_article_path(team, article)
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
