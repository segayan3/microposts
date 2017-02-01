class FavoritesController < ApplicationController
  def create
    @user_id = current_user.id
    @micropost_id = Micropost.find(params[:id]).id
    @favorite = Favorite.new(user_id: @user_id, micropost_id: @micropost_id)
    
    if @favorite.save
      flash[:succes] = "お気に入りに登録しました"
      redirect_to root_path
    end
  end
  
  #def favorites
    #@user = User.find(params[:id])
    #@microposts = @user.favorite_microposts
    #render 'favorites'
  #end
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(@micropost)
    #redirect_to :back
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(@micropost)
    #redirect_to :back
  end
end
