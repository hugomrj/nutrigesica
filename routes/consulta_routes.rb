# routes/consulta_routes.rb
# (No incluyas `require 'sinatra'` aquí, porque ya se cargó en app.rb)

# Listado general de consultas (con paginación)
get '/consultas' do
  page = (params[:page] || 1).to_i
  @consultas = Consulta.order(Sequel.desc(:fecha))
                       .extension(:pagination)
                       .paginate(page, 20)
  erb :"consultas/index"
end



# Formulario para nueva consulta
get '/consultas/new' do
    
  @pacientes = Paciente.order(:nombres).all
  @consulta = Consulta.new(fecha: Date.today)
  
  puts ">>> PACIENTES CARGADOS: #{@pacientes.count}" # Para verificar datos
  
  erb :"consultas/new"
end




# Crear una nueva consulta
post '/consultas' do
  datos = params[:consulta] || {}
  datos[:paciente_id] ||= params[:paciente_id]
  
  @consulta = Consulta.new(datos)
  
  if @consulta.save
    # Guardamos el mensaje en la sesión "flash"
    flash[:success] = "Consulta registrada exitosamente"
    redirect '/consultas'
  else
    @pacientes = Paciente.order(:apellidos).all
    erb :"consultas/new"
  end
end






# Ver detalle de una consulta
get '/consultas/:id' do
  @consulta = Consulta[params[:id]]
  @paciente = @consulta.paciente
  erb :"consultas/show"
end



