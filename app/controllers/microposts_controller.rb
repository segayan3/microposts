class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:succes] = "Micropost created!"
      redirect_to root_url
    else
      #@feed_items = current_user.feed_items.includes(:user).order(created_ad: :desc)
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_path
  end
  
  def reTweet
    original_micropost = Micropost.find(params[:id])
    retweet = current_user.microposts.build
    retweet.original_id = original_micropost.id
    retweet.content = "#{original_micropost.user.name}さんのツイート : #{original_micropost.content}"
    
    if retweet.save
      flash[:succes] = "ReTweet created!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content,:original_id, :image, :video)
  end
end
