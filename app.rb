require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'models/user'

# Configuraciones
set :root, File.dirname(__FILE__)
set :views, proc { File.join(root, "views") }


# AGREGA ESTO:
use Rack::Session::Cookie, 
  :key => 'rack.session',
  :path => '/',
  :secret => 'a7b8c9d0e1f2g3h4i5j6k7l8m9n0o1p2q3r4s5t6u7v8w9x0y1z2a3b4c5d6e7f8' 



# Este bloque corre antes de CUALQUIER ruta
before do
  @current_user = User[session[:user_id]] if session[:user_id]
end



# La raíz '/' ahora es un "tráfico"
get '/' do
  if session[:user_id]
    redirect '/dashboard'
  else
    redirect '/login'
  end
end

# El login ahora es independiente
get '/login' do
  redirect '/dashboard' if session[:user_id]
  erb :login, layout: :layout_base # <--- Usa el base sin Nav
end


post '/login' do
  puts ">>> INTENTO DE LOGIN <<<"
  puts "Params recibidos: #{params.inspect}"
  
  user = User.first(username: params[:username].strip)
  puts "Usuario encontrado en DB: #{user.inspect}"
  
  if user && user.password == params[:password]
    puts "LOGIN EXITOSO - Redirigiendo..."
    session[:user_id] = user.id
    redirect '/dashboard'
  else
    puts "LOGIN FALLIDO"
    @error = "Credenciales inválidas"
    erb :login, layout: :layout_base
  end
end



# Ruta exclusiva para el Dashboard
get '/dashboard' do
  # Protección: si alguien intenta entrar por URL sin permiso
  redirect '/login' unless session[:user_id]
  
  erb :index # O puedes crear dashboard.erb si prefieres
end

