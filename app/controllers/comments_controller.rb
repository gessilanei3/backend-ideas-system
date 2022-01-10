class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  # def index
  #   @comments = Comment.all

  #   render json: @comments.to_json(:include => [:user, :idea]), status: :ok
  # end

  def index
    if (params[:idea_id])
         @comments = Comment.where(idea_id: params[:idea_id])
    else
        @comments = Comment.all
    end
    render json: @comments.to_json(:include => [:user, :idea]), status: :ok
  end


  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:com_description, :com_image, :idea_id, :user_id)
    end
end
