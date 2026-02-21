require_relative '../database'

class Paciente < Sequel::Model(:pacientes)
  # Validaciones básicas (opcional, requiere el plugin :validation_helpers)
  plugin :validation_helpers

  def validate
    super
    validates_presence [:nombres, :apellidos, :fecha_nacimiento, :email]
    validates_unique :email
    validates_format /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, :email, message: 'no es un correo válido'
  end

  # Método de conveniencia para calcular la edad real desde Ruby
  def edad_actual
    return nil unless fecha_nacimiento
    hoy = Date.today
    hoy.year - fecha_nacimiento.year - ((hoy.month > fecha_nacimiento.month || (hoy.month == fecha_nacimiento.month && hoy.day >= fecha_nacimiento.day)) ? 0 : 1)
  end
end