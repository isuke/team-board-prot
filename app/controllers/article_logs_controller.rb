class ArticleLogsController < ApplicationController
  include MemberAuthorize
  before_action -> { @team = Team.find(params[:team_id]) }
  before_action -> { member_authorize @team }

  def index
    @article_logs = Article.find(params[:id]).logs
  end

  def show
    @article_log = ArticleLog.find(params[:id])
    @latest_article_log = @article_log.originator.latest_log
  end

  def diff
    @left_article_log  = ArticleLog.find(params[:id1])
    @right_article_log = ArticleLog.find(params[:id2])
  end

end
