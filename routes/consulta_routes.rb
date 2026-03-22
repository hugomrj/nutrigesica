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
    redirect url("/consultas")
  else
    @pacientes = Paciente.order(:apellidos).all
    erb :"consultas/new"
  end
end


#   editar una consulta existente
get '/consultas/:id/editar' do
  @consulta = Consulta[params[:id]]
  @pacientes = Paciente.order(:apellidos).all # Necesario para el select del formulario
  
  if @consulta
    erb :"consultas/edit"
  else
    flash[:error] = "Consulta no encontrada"
    redirect url("/consultas")
  end
end

put '/consultas/:id' do
  @consulta = Consulta[params[:id]]
  
  # 1. Cargamos los datos del formulario en el objeto
  # (El modelo ya se encarga de limpiar los "" gracias a tu before_validation)
  @consulta.set(params[:consulta] || {})

  # 2. Lógica inteligente de guardado:
  # Si NO hubo cambios (!modified?) o si el guardado es exitoso, es un éxito para el usuario.
  if !@consulta.modified? || @consulta.save
    flash[:success] = "Consulta actualizada correctamente"
    redirect url("/consultas")
  else
    # Si llega aquí es por un error real de validación o base de datos
    @pacientes = Paciente.order(:apellidos).all
    flash.now[:error] = "No se pudieron guardar los cambios. Verifique los datos."
    erb :"consultas/edit"
  end
end


# Ver detalle de una consulta específica
get '/consultas/:id' do
  @consulta = Consulta[params[:id]]
  
  if @consulta
    erb :"consultas/show"
  else
    flash[:error] = "Consulta no encontrada"
    redirect url('/consultas')
  end
end