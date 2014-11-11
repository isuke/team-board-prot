class ArticlesController < ApplicationController
  include MemberAuthorize
  before_action -> { member_authorize params[:team_id] }

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.team = @team
    if !params["preview"] && @article.save
      flash[:success] = "Create '#{@article.title}'"
      redirect_to article_path(@team, @article)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.attributes = article_params
    @article.user = current_user
    if !params["preview"] && @article.save
      flash[:success] = "Save Article '#{@article.title}'."
      redirect_to article_path(@team, @article)
    else
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    title = article.title
    article.destroy
    flash[:success] = "'#{title}'' deleted."
    redirect_to @team
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

end
