require 'pry'
class UserController < ApplicationController
 
 get '/home' do 
    redirect_if_not_logged_in
   erb :'/users/home' 
 end 
 
 get '/show/edit' do 
    redirect_if_not_logged_in
  current_user
   erb :'/events/edit'
 end 
 

 patch '/show/:id' do 
    redirect_if_not_logged_in
   @user = User.find(params[:id])
   @user.update(username: params["username"], password: params["password"] )
   redirect '/show'
 end 


end
