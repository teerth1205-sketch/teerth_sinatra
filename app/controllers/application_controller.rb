require 'pry'
class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets
  
 configure do
    enable :sessions
    set :session_secret, "password_security"
  end
  
  get '/' do
    erb :'/application/home' , :layout => :layout
  end
  
  get '/application/signup' do
   # @errors = @user.errors.messages
    erb :'/application/signup'
  end 
  
  post "/signup" do
    @user = User.new(:username => params[:username], :password => params[:password],:name => params[:name])
    
    if @user.save
      
      redirect "/application/login"
      
    else
      
      @errors = @user.errors.messages
      erb :'application/signup'
	 
	  end 
  end
 
get '/application/login' do
  erb :'/application/login'
end
  
 post "/application/login" do
   #binding.pry
    @user = User.find_by(username: params["username"])
		 
		 if @user && @user.authenticate(params[:password])
	
		   session[:user_id] = @user.id
        redirect '/home'
      else
        @error = "Wrong Username or Password"
      erb :"/application/login"
     end
  end

 
 get '/logout' do
 if session[:user_id] != nil
      session.destroy
      redirect to '/application/login'
    else
      redirect to '/'
    end
  
 end 
 
  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/application/login"
      end
    end

    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      @user ||= User.find(session[:user_id])
    end 
    
    def ms(pace)
    "%02d:%02d" % [pace.floor, (pace % 1 * 60).floor]
    end
    
    def conditional(t)
      if Rsvp.find_by(:event_id => t.id)
         !!(session[:user_id] != Rsvp.find_by(:event_id => t.id).user_id)
       end 
    end

  end
 
 end 
