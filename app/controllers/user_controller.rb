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

 get '/show/runs' do 
    redirect_if_not_logged_in
 @runs = Run.where(:user_id => session[:user_id])
 erb :'/landmarks/runpage'
 end 
 
 post '/run/add' do 
   redirect_if_not_logged_in
   
   @runs = Run.where(:user_id => session[:user_id])
  @run = Run.new(:time => params["time"], :miles => params["miles"], :location => params["location"], :date => params["run_date"], :user_id => session[:user_id])
  if @run.save
   redirect '/show/runs' 
 else 
    #@runs = Run.all
   @errors = @run.errors.messages
   erb :'landmarks/runpage'
 end 
 end 
 
 get "/runs/:id/edit" do
    redirect_if_not_logged_in
   @run = Run.find(params[:id])
   erb :'landmarks/update'
 end 
   
  
 patch '/runs/:id' do
    redirect_if_not_logged_in
   @run = Run.find(params[:id])
   @run.update(:time => params["time"], :miles => params["miles"], :location => params["location"], :date => params["run_date"], :user_id => session[:user_id])
   redirect  '/show/runs' 
 end 
 
 delete '/runs/:id' do 
    redirect_if_not_logged_in
   @run = Run.find(params[:id])
   @run.destroy
   redirect '/show/runs'
 end 
 
end
