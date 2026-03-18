==========================================================
GUÍA DE INSTALACIÓN INICIAL - PROYECTO NUTRIGESICA
==========================================================
Servidor: Ubuntu 22.04 LTS / 24.04 LTS
Tecnologías: Ruby, Sinatra, PostgreSQL, Nginx
----------------------------------------------------------

1. ACTUALIZACIÓN DEL SISTEMA
----------------------------------------------------------
sudo apt update && sudo apt upgrade -y

2. INSTALACIÓN DE DEPENDENCIAS ESENCIALES
----------------------------------------------------------
# Herramientas de compilación y librerías para gemas nativas (como 'pg')
sudo apt install -y build-essential libpq-dev git curl

3. INSTALACIÓN DE RUBY Y BUNDLER
----------------------------------------------------------
sudo apt install -y ruby-full
sudo gem install bundler

4. CONFIGURACIÓN DE POSTGRESQL
----------------------------------------------------------
sudo apt install -y postgresql postgresql-contrib

# Iniciar servicio si no está corriendo
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Crear base de datos y usuario (Ajustar 'usuario' y 'password')
sudo -u postgres psql -c "CREATE DATABASE nutrigesica_database;"
sudo -u postgres psql -c "CREATE USER hugo WITH PASSWORD 'tu_password_aqui';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE nutrigesica_database TO hugo;"

5. DESPLIEGUE DEL CÓDIGO
----------------------------------------------------------
# Clonar repositorio
git clone <URL_DE_TU_REPOSITORIO>
cd nutrigesica

# Instalar gemas del proyecto
bundle install

6. RESTAURACIÓN DE DATOS (BACKUP)
----------------------------------------------------------
# Importar el archivo .sql que subiste al git
sudo -u postgres psql nutrigesica_database < nutrigesica_backup.sql

7. PRUEBA DE ARRANQUE (PUERTO 4567)
----------------------------------------------------------
bundle exec ruby app.rb -o 0.0.0.0

==========================================================
NOTAS ADICIONALES:
- Si usas un firewall (ufw), recuerda habilitar el puerto: 
  sudo ufw allow 4567/tcp
- Para producción, se recomienda configurar Systemd y Nginx.
==========================================================