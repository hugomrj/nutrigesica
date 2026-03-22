require_relative '../database'

class Paciente < Sequel::Model(:pacientes)
  set_primary_key :id_paciente

  # Relaciones
  one_to_many :consultas, class: :Consulta, key: :paciente_id
  one_to_many :controles_peso, class: :ControlPeso, key: :paciente_id

  # Este método se ejecuta AUTOMÁTICAMENTE antes de guardar o validar
  def before_validation
    # Iteramos sobre todos los campos que tiene el objeto en ese momento
    values.each do |columna, valor|
      # Si el valor es un texto y está vacío o solo tiene espacios...
      if valor.is_a?(String) && valor.strip.empty?
        # Lo seteamos como nil (Nulo en la DB)
        self[columna] = nil
      end
    end
    
    super # Importante: llama al comportamiento original de Sequel
  end
end