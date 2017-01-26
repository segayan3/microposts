class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def create
    @microposts = current_user.microposts.build(micropost_params)
    if @microposts.save
      flash[:succes] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_ad: :desc)
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
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
