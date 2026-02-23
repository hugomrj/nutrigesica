require_relative '../database'

class Paciente < Sequel::Model(:pacientes)
  plugin :validation_helpers
  self.raise_on_save_failure = false

  def validate
    super
    # Campos estrictamente obligatorios
    validates_presence [:nombres, :apellidos, :fecha_nacimiento]
    
    # Email opcional: solo valida si el usuario escribe algo
    validates_unique :email, allow_blank: true
    validates_format /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, :email, 
                     message: 'no es un correo válido', 
                     allow_blank: true
  end

  # Calcula la edad basándose en la fecha de nacimiento
  def edad_actual
    return nil unless fecha_nacimiento
    hoy = Date.today
    # Ajuste: fecha_nacimiento debe ser un objeto Date/Time
    dob = fecha_nacimiento.to_date
    hoy.year - dob.year - ((hoy.month > dob.month || (hoy.month == dob.month && hoy.day >= dob.day)) ? 0 : 1)
  end
end