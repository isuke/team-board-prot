class CommentsController < ApplicationController
  include MemberAuthorize
  before_action -> { @team = Team.find(params[:team_id]) }
  before_action -> { member_authorize @team }

  def create
    @article = Article.find(params[:id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash.now[:success] = "Add Comment."
    end
    respond_to do |format|
      format.html { redirect_to article_path(@team, @article) }
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :formatted_content)
    end

end
