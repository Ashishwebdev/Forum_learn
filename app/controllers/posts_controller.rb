class PostsController < ApplicationController
  before_action :find_post, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all
  end
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post

    else
      render new_post_path
    end
  end

  def show

  end

  def edit

  end

  def update

     if @post.update(post_params)
       redirect_to @post
     else
     render 'edit'
     end

  end

  def destroy
    if current_user.id == @post.user_id
      @post.destroy
    end
      redirect_to root_path
  end
  private


  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end


end
