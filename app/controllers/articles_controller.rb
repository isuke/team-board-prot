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
    ActiveRecord::Base.transaction do
      @article = Article.create
      @article.logs.build(params.permit(:title, :content)).save!
    end
    flash[:success] = "Create '#{@article.title}'"
    redirect_to @article
  rescue
    render 'new'
  end

  def edit
    @article_log = Article.find(params[:id]).latest_log.dup
  end

  def update
    @article = Article.find(params[:id])
    @article_log = @article.logs.build(params.permit(:title, :content))
    if @article_log.save
      @article.touch
      flash[:success] = "Save Article '#{@article.title}'."
      redirect_to article_path @article
    else
      render 'show'
    end
  end

  def destroy
    # TODO
  end
end
