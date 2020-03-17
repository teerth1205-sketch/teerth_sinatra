require 'pry'
class EventController < ApplicationController
  
  get '/events/home' do 
     redirect_if_not_logged_in
    @event = Event.all
    erb :'/landmarks/event'
  end
  
 
  post '/events/new' do
     redirect_if_not_logged_in
     
    @event = Event.new(:time => params["time"], :location => params["location"], :description => params["description"], :date => params["date"])
    if @event.save 
    @user = User.find(session[:user_id])
     @user.events << @event
     redirect '/show'
   else 
     
     @errorss = "You need to input for all fields"
   #  erb :'/landmarks/show'
  end 
  end 
    
   
  post '/events/events/:id/join' do
    redirect_if_not_logged_in
    @event =Event.all
    event = Event.find(params[:id])
     @user = User.find(session[:user_id])
     if @user.events.find_by(:id => event.id)
        @error = "Already Attending"
        erb :'/landmarks/event'
     else
       @user.events << event
       redirect '/show'
     end 
  end
  
  get '/events/:id/update' do 
     redirect_if_not_logged_in
    @event = Event.find(params[:id])
    erb :'landmarks/new'
  end 
  
  patch '/events/:id/update' do 
     redirect_if_not_logged_in
     @event = Event.find(params[:id])
     @rsvp = Rsvp.find_by(:event_id => params[:id])
     if @rsvp.user_id == session[:user_id]
     @event.update(:time => params["time"], :location => params["location"], :date => params["date"], :description => params["description"])
     redirect '/show'
     else
      @error = "you cannot update this event"
     end 
   end 
   
   delete '/events/:id/delete' do 
      redirect_if_not_logged_in
     @event = Event.find(params[:id])
     @rsvp = Rsvp.find_by(:event_id => params[:id])
     if @rsvp.user_id == session[:user_id]
     @event.destroy
     redirect '/show'
     else
       @error1 = "you cannot delete this event"
     end
   end 
   
  delete '/events/:id/remove' do 
     redirect_if_not_logged_in
    @user = User.find(session[:user_id])
    @rsvp = Rsvp.find_by(:user_id => session[:user_id], :event_id => params[:id])
    @rsvp.delete
    redirect '/show'

  end 
  
end 