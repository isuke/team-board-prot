class ArticleLogsController < ApplicationController

  def index
    @article_logs = Article.find(params[:article_id]).logs
  end

  def show
    @article_log = ArticleLog.find(params[:id])
  end

  private

    def article_log_params
      params.require(:article_log).permit(:title, :content)
    end
end
