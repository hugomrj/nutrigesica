require_relative '../database'

class Consulta < Sequel::Model(:consultas)
  # Solo necesitas esto si tu clave primaria no se llama "id"
  set_primary_key :id_consulta 
end