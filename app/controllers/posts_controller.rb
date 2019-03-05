# frozen_string_literal: true

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to posts_url
  end

  def index
    redirect_to new_user_session_path unless current_user
    @user = current_user
    @posts = Post.all
  end

  def destroy
    if Post.find(params[:id]).user_id == current_user.id
      Post.find(params[:id]).destroy
      redirect_to posts_url
    else
      redirect_to posts_url
    end
  end

  private
  def post_params
    return_hash = params.require(:post).permit(:message)
    return_hash['user_id'] = current_user.id
    return return_hash
  end
end
