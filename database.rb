require 'sequel'
require 'dotenv'

# Carga las variables del archivo .env
Dotenv.load

# Configuración usando las variables de entorno
DB = Sequel.connect(
  adapter:  'postgres',
  user:     ENV['DATABASE_USER'],
  password: ENV['DATABASE_PASSWORD'],
  host:     ENV['DATABASE_HOST'],
  port:     ENV['DATABASE_PORT'],
  database: ENV['DATABASE_NAME']
)

