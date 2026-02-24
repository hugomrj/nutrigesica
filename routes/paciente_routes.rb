# routes/paciente_routes.rb
# (No incluyas `require 'sinatra'` aquí, porque ya se cargó en app.rb)

# Listado
get '/pacientes' do
    page = (params[:page] || 1).to_i
    @pacientes_ds = Paciente.dataset.extension(:pagination).paginate(page, 10)
    
    # PRUEBA DE DEPURACIÓN:
    puts "Cantidad de pacientes: #{@pacientes_ds.count}" 
    
    erb :"pacientes/index"
  end
  
  
  # Formulario Nuevo
  get '/pacientes/nuevo' do
    erb :"pacientes/new"
  end
  
  
  
  # Crear un nuevo paciente
  post '/pacientes' do
    # Muestra qué llega desde el formulario
    puts "\n[DEBUG] PARAMETROS RECIBIDOS: #{params.inspect}" 
  
    allowed_params = params.select do |key, _|
      ['nombres', 'apellidos', 'fecha_nacimiento', 'email', 'celular', 
       'ocupacion', 'ciudad', 'barrio'].include?(key)
    end
  
    @paciente = Paciente.new(allowed_params)
  
    if @paciente.save # .save ya ejecuta .valid? internamente en Sequel
      flash[:notice] = 'Paciente creado correctamente.'
      redirect '/pacientes'
    else
      # --- MENSAJE EN CONSOLA SI ALGO SALE MAL ---
      puts "\n" + "!" * 30
      puts "ERROR AL GUARDAR PACIENTE:"
      # Imprime la lista de errores (ej: ["nombres is not present", "email is already taken"])
      p @paciente.errors.full_messages 
      puts "!" * 30 + "\n"
      # -------------------------------------------
      
      flash.now[:error] = "No se pudo guardar: " + @paciente.errors.full_messages.join(", ")
      erb :"pacientes/new"
    end
  end
  
  
  
  
  # Editar (Cargando el paciente)
  get '/pacientes/:id/editar' do
    @paciente = Paciente[params[:id]]
    erb :"pacientes/edit"
  end
  
  
  
  