require 'sinatra'
require 'slim'
require 'sass'
require 'sinatra/reloader' if development?
require './song'

get('/styles.css'){ scss :styles }

configure do
    enable :sessions
    set :session_secret, '123rre4456ii'
    set :username, 'frank'
    set :password, 'sinatra'
end



get '/' do 
    slim :home
end

get '/about' do
    @title = "All about this Website"
    slim :about
end

get '/contact' do 
    slim :contact
end

get '/login' do
    slim :login
end


post '/login' do
    if params[:username] == settings.username && params[:password] == settings.password
        session[:admin] = true
        redirect to ('/songs')
    else
        slim :login
    end
end

get '/logout' do
    session.clear
    redirect to ('/login')
end

