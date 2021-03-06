require 'pry'
class EventController < ApplicationController
  
  get '/events' do 
     redirect_if_not_logged_in
    @event = Event.all
    erb :'/events/index'
  end
  
 
  post '/events' do
     redirect_if_not_logged_in
     
    event = current_user.events.build(:time => params["time"], :location => params["location"], :description => params["description"], :date => params["date"])
    if current_user.save
     redirect '/home'
   else 
     current_user.reload
     @errorss = event.errors.full_messages
     erb :'users/home'
    end 
  end 
    
   
  post '/events/:id/join' do
    redirect_if_not_logged_in
    @event =Event.all
    event = Event.find(params[:id])
    current_user
     if @user.events.find_by(:id => event.id)
        @error = "Already Attending"
        erb :'events/index'
     else
       @user.events << event
       redirect '/home'
     end 
  end
  
  get '/events/:id/update' do 
     redirect_if_not_logged_in
    @event = Event.find(params[:id])
    erb :'events/new'
  end 
  
  get '/events/:id/edit' do 
    redirect_if_not_logged_in
    @event = Event.find(params[:id])
   erb :'/events/edit'
 end 
  
  patch '/events/:id/update' do 
     redirect_if_not_logged_in
     @event = Event.find(params[:id])
     @rsvp = Rsvp.find_by(:event_id => params[:id])
     if @rsvp.user_id == session[:user_id]
     @event.update(:time => params["time"], :location => params["location"], :date => params["date"], :description => params["description"])
     redirect '/show'
     else
     error
     end 
   end 
   
   delete '/events/:id/delete' do 
      redirect_if_not_logged_in
     @event = current_user.events.find(params[:id])
     @rsvp = Rsvp.find_by(:event_id => params[:id])
     if @rsvp.user_id == session[:user_id]
     @event.destroy
     redirect '/home'
     else
       @error1 = "you cannot delete this event"
       
     end
   end 
   
  delete '/events/:id/remove' do 
     redirect_if_not_logged_in
    current_user
    @rsvp = Rsvp.find_by(:user_id => session[:user_id], :event_id => params[:id])
    @rsvp.delete
    redirect '/home'

  end 
  
end 