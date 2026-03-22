require_relative '../database'

class Consulta < Sequel::Model(:consultas)
  # 1. Configuración de seguridad y clave
  set_primary_key :id_consulta
  plugin :whitelist_security

  # 2. Asociaciones
  many_to_one :paciente, class: :Paciente, key: :paciente_id

  # 3. Campos permitidos para actualización masiva
  set_allowed_columns :paciente_id, :fecha, :peso_actual, :talla, 
                      :motivo_consulta, :observaciones_generales, 
                      :presion_arterial, :antecedentes_salud, 
                      :antecedentes_familiares, :estilo_vida, 
                      :indicadores_dieteticos, :dieta_habitual

  # 4. COMPORTAMIENTO AUTOMÁTICO: Limpieza de datos
  def before_validation
    # Limpia cualquier string vacío de los campos de la consulta
    values.each do |columna, valor|
      if valor.is_a?(String) && valor.strip.empty?
        self[columna] = nil
      end
    end
    super
  end

  # 5. BONUS: Formateo automático de fecha (opcional)
  # Si no viene fecha, le ponemos la de hoy por defecto
  def before_create
    self.fecha ||= Date.today
    super
  end
end