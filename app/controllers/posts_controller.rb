class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    update_collaborations
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def update_collaborations
    current = @post.collaborations.pluck(:user_id)
    update_ids = params[:post][:collaborator_ids].reject(&:empty?).map(&:to_i)

    @post.collaborations.where(user_id: (current - update_ids)).destroy_all

    (update_ids - current).each do |id|
      @post.collaborations.create(user_id: id)
    end
  end
end
