class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:comment, :user_id))
    @comment.user_id = current_user.id if current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
    end
    redirect_to post_path(@post)
  end

  def edit
    if current_user.id == @comment.user_id

     @post = Post.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
    end

  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(params[:comment].permit(:comment))
     redirect_to post_path(@post)

    else
      render 'edit'

    end

  end

end
