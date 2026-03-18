require 'sinatra'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'cgi'

# Cargar modelos, helpers y rutas
Dir["./models/*.rb"].each { |file| require file }
Dir["./helpers/*.rb"].each { |file| require file }
Dir["./routes/*.rb"].each { |file| require file }

# Configuraciones base
set :root, File.dirname(__FILE__)
set :views, proc { File.join(root, "views") }

# Ahora la ruta de la cookie es fija para ambos entornos
use Rack::Session::Cookie, 
  :key => 'rack.session',
  :path => '/nutrigesica/', 
  :secret => 'a7b8c9d0e1f2g3h4i5j6k7l8m9n0o1p2q3r4s5t6u7v8w9x0y1z2a3b4c5d6e7f8'

register Sinatra::Flash
helpers PaginationHelper

before do
  @current_user = User[session[:user_id]] if session[:user_id]
end

# --- RUTAS ---
# IMPORTANTE: Al usar 'map' en config.ru, estas rutas se vuelven 
# relativas a /nutrigesica/. Es decir, '/' aquí es '/nutrigesica/' en el navegador.

get '/' do
  if session[:user_id]
    redirect to('/dashboard')
  else
    redirect to('/login')
  end
end

get '/login' do
  redirect to('/dashboard') if session[:user_id]
  erb :login, layout: :layout_base
end

post '/login' do
  user = User.first(username: params[:username].strip)
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect to('/dashboard')
  else
    @error = "Credenciales inválidas"
    erb :login, layout: :layout_base
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

get '/dashboard' do
  redirect to('/login') unless session[:user_id]
  erb :index
end