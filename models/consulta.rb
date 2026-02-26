require_relative '../database'

class Consulta < Sequel::Model(:consultas)
  # 1. Configuración de seguridad y clave
  set_primary_key :id_consulta
  plugin :whitelist_security

  # 2. LA ASOCIACIÓN (Esto arregla el error)
  # Esto le dice a Sequel: "Busca en la tabla pacientes usando la columna paciente_id"
  many_to_one :paciente, class: :Paciente, key: :paciente_id

  # 3. Tu lista de campos
  set_allowed_columns :paciente_id, :fecha, :peso_actual, :talla, 
                      :motivo_consulta, :observaciones_generales, 
                      :presion_arterial, :antecedentes_salud, 
                      :antecedentes_familiares, :estilo_vida, 
                      :indicadores_dieteticos, :dieta_habitual
end