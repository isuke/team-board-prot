class ArticleLogsController < ApplicationController

  def index
    @article_logs = Article.find(params[:id]).logs
  end

  def show
    @article_log = ArticleLog.find(params[:id])
    @latest_article_log = @article_log.article.latest_log
  end

  def diff
    @left_article_log  = ArticleLog.find(params[:id1])
    @right_article_log = ArticleLog.find(params[:id2])
  end

  private

    def article_log_params
      params.require(:article_log).permit(:title, :content)
    end
end
