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







# Ver detalle de una consulta
get '/consultas/:id' do
  @consulta = Consulta[params[:id]]
  @paciente = @consulta.paciente
  erb :"consultas/show"
end






# Crear consulta
post '/pacientes/:paciente_id/consultas' do
  @paciente = Paciente[params[:paciente_id]]
  @consulta = Consulta.new(params[:consulta])
  @consulta.paciente_id = @paciente.id_paciente
  if @consulta.save
    flash[:success] = "Consulta guardada correctamente"
    redirect "/pacientes/#{@paciente.id_paciente}"
  else
    erb :"consultas/new"
  end
end

# Formulario para editar consulta
get '/consultas/:id/editar' do
  @consulta = Consulta[params[:id]]
  @paciente = @consulta.paciente
  erb :"consultas/edit"
end

# Actualizar consulta
put '/consultas/:id' do
  @consulta = Consulta[params[:id]]
  if @consulta.update(params[:consulta])
    flash[:notice] = "Consulta actualizada"
    redirect "/consultas/#{@consulta.id_consulta}"
  else
    @paciente = @consulta.paciente
    erb :"consultas/edit"
  end
end

# Eliminar consulta
post '/consultas/:id/eliminar' do
  consulta = Consulta[params[:id]]
  paciente_id = consulta.paciente_id
  if consulta.destroy
    flash[:notice] = "Consulta eliminada"
  else
    flash[:error] = "No se pudo eliminar"
  end
  redirect "/pacientes/#{paciente_id}"
end