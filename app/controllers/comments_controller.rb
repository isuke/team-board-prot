class CommentsController < ApplicationController
  include MemberAuthorize
  before_action :member_authorize

  def create
    @article = Article.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.user    = current_user
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
      params.require(:comment).permit(:content)
    end

end
