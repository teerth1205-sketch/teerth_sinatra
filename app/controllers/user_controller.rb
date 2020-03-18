require 'pry'
class UserController < ApplicationController
 
 get '/show' do 
    redirect_if_not_logged_in
   @user = User.find(session[:user_id])
   @events = @user.events
  # binding.pry
   erb :'/landmarks/show' 
 end 
 
 get '/show/edit' do 
    redirect_if_not_logged_in
   @user = User.find(session[:user_id])
   erb :'/landmarks/edit'
 end 
 

 patch '/show/edit' do 
    redirect_if_not_logged_in
   @user = User.find(session[:user_id])
   @user.update(username: params["username"], password: params["password"] )
   redirect '/show'
 end 


end
