require 'pry'
class RunController < ApplicationController

get '/runs' do 
    redirect_if_not_logged_in
 @runs = Run.where(:user_id => session[:user_id])
 erb :'/runs/index'
 end 
 
 post '/runs' do 
   redirect_if_not_logged_in
   
  @runs = Run.where(:user_id => session[:user_id])
  @run = Run.new(:time => params["time"], :miles => params["miles"], :location => params["location"], :date => params["run_date"], :user_id => session[:user_id])
  if @run.save
   redirect '/runs' 
 else 
    #@runs = Run.all
   @errors = @run.errors.messages
   erb :'runs/index'
 end 
 end 
 
 get "/runs/:id/edit" do
    redirect_if_not_logged_in
   @run = Run.find_by(:id => params[:id])
   #binding.pry
   erb :'events/update'
 end 
   
  
 patch "/runs/:id" do
    redirect_if_not_logged_in
   @run = Run.find(params[:id])
   @run.update(:time => params["time"], :miles => params["miles"], :location => params["location"], :date => params["run_date"], :user_id => session[:user_id])
   redirect  '/runs' 
 end 
 
 delete '/runs/:id' do 
    redirect_if_not_logged_in
   @run = Run.find(params[:id])
   @run.destroy
   redirect '/runs'
 end 
 
 end 