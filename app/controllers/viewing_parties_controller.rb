class ViewingPartiesController < ApplicationController 
  def new
    if current_user
      @user = User.find(params[:user_id])
      @movie = Movie.find(params[:movie_id])
    else
      redirect_to movie_path(params[:user_id], params[:movie_id])
      flash[:error] = "You must be registered and logged in to create a viewing party."
    end
  end 
  
  def create
    user = User.find(params[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/users/#{params[:user_id]}"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 