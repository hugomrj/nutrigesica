require_relative '../database'

class Paciente < Sequel::Model(:pacientes)
  set_primary_key :id_paciente

  def before_validation
    self.email = nil if email&.strip == ''
    super
  end
end