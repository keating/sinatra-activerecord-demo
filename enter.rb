require 'sinatra/base'
require 'active_record'
require_relative 'models/user'
require_relative 'heroku_db_url'

class Enter < Sinatra::Base
  extend HerokuDbUrl

  ActiveRecord::Base.establish_connection(
      config_by_url(ENV['DATABASE_URL']) || YAML::load(File.open('config/database.yml'))["development"]
  )

  get '/' do
    @title = 'hello title'
    erb :index, :layout => :application
  end

  get '/users' do
    @users = User.order('created_at desc')
    erb :'users/index', :layout => :application
  end

  get '/users/new' do
    @users = User.new
    erb :'users/new', :layout => :application
  end

  post '/users/create' do
    @user = User.new(params[:user])
    if @user.save
      redirect 'users'
    else
      erb :'users/new', :layout => :application
    end
  end

  run! if app_file == $0

end