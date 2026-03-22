source 'https://rubygems.org'

# Framework y extensiones
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-flash'

# Base de Datos (PostgreSQL en Paraguay)
gem 'pg'              # Driver nativo
gem 'sequel'          # ORM ligero y potente

# Utilidades de entorno y servidor
gem 'dotenv'          # Para manejar el .env (DB_URL, SECRET, etc.)
gem 'rackup', '~> 2.3'
gem 'puma', '~> 7.2'
gem 'rake'            # Para automatizar tareas (migraciones, etc.)

# Herramientas de desarrollo
group :development do
  # Eliminamos 'rerun' porque choca con tu versión de Bundler
  gem 'sinatra-reloader' 
end