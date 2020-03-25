require 'pry'
class UserController < ApplicationController
 
 get '/show' do 
    redirect_if_not_logged_in
   current_user 
   @events = @user.events
  # binding.pry
   erb :'/landmarks/show' 
 end 
 
 get '/show/edit' do 
    redirect_if_not_logged_in
  current_user
   erb :'/landmarks/edit'
 end 
 

 patch '/show/:id' do 
    redirect_if_not_logged_in
   @user = User.find(params[:id])
   @user.update(username: params["username"], password: params["password"] )
   redirect '/show'
 end 


end
