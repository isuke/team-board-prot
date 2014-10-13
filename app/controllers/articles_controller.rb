class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_log_params)
    if @article.save
      flash[:success] = "Create '#{@article.title}'"
      redirect_to @article
    else
      flash[:danger] = "create error" # TODO
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_log_params)
      flash[:success] = "Save Article '#{@article.title}'."
      redirect_to article_path @article
    else
      flash[:danger] = "edit error" # TODO
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    title = article.title
    article.destroy
    flash[:success] = "'#{title}'' deleted."
    redirect_to articles_path
  end

  private

    def article_log_params
      params.require(:article).permit(:title, :content)
    end

end
