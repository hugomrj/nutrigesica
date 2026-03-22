# routes/paciente_routes.rb
# (No incluyas `require 'sinatra'` aquí, porque ya se cargó en app.rb)




# Listado con Búsqueda y Paginación
get '/pacientes' do
  page = (params[:page] || 1).to_i
  @query = params[:q].to_s.strip # Capturamos lo que el usuario escribe

  # 1. Empezamos con el dataset base
  ds = Paciente.dataset

  # 2. Si el usuario escribió algo en el buscador, filtramos
  unless @query.empty?
    search_pattern = "%#{@query}%"
    ds = ds.where(
      Sequel.ilike(:nombres, search_pattern) | 
      Sequel.ilike(:apellidos, search_pattern) |
      Sequel.ilike(:ciudad, search_pattern)
    )
  end

  # 3. Ordenamos por los más recientes y paginamos sobre el resultado (filtrado o no)
  # @pacientes_ds = ds.order(Sequel.desc(:id_paciente)).extension(:pagination).paginate(page, 10)
  @pacientes_ds = ds.extension(:pagination).order(Sequel.desc(:id_paciente)).paginate(page, 10)

  # PRUEBA DE DEPURACIÓN:
  puts "Búsqueda: '#{@query}' | Resultados en esta página: #{@pacientes_ds.count}" 
  
  erb :"pacientes/index"
end





  
  
  # Formulario Nuevo
  get '/pacientes/nuevo' do
    erb :"pacientes/new"
  end
  
  
  
  post '/pacientes' do
    # Sequel permite crear y guardar en un solo paso
    @paciente = Paciente.new(params[:paciente]) 
    
    if @paciente.save
      flash[:success] = "Paciente creado"
      redirect url('/pacientes')
    else
      erb :"pacientes/new"
    end
  end
  
  
  
  # Editar (Cargando el paciente)
  get '/pacientes/:id/editar' do
    @paciente = Paciente[params[:id]]
    erb :"pacientes/edit"
  end
  
  put '/pacientes/:id' do
    @paciente = Paciente[params[:id]]
    
    # 1. Asignamos los nuevos datos al objeto
    @paciente.set(params[:paciente])
    
    # 2. Verificamos si hubo cambios O si simplemente queremos confirmar el éxito
    if !@paciente.modified? || @paciente.save
      flash[:success] = "Datos actualizados"
      redirect url("/pacientes")
    else
      flash.now[:error] = "No se pudieron guardar los cambios"
      erb :"pacientes/edit"
    end
  end




  # Ver detalle de un paciente
  get '/pacientes/:id' do
    @paciente = Paciente[params[:id]]
    erb :"pacientes/show"
  end








# Eliminar un paciente
post '/pacientes/:id/eliminar' do
  paciente = Paciente[params[:id]]
  
  if paciente
    paciente.destroy
    flash[:success] = 'Paciente eliminado correctamente.'
  else
    flash[:error] = 'Paciente no encontrado.'
  end
  
  redirect url('/pacientes')
end