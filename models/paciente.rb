require_relative '../database'

class Paciente < Sequel::Model(:pacientes)
  set_primary_key :id_paciente

  one_to_many :consultas, class: :Consulta, key: :paciente_id
  one_to_many :controles_peso, class: :ControlPeso, key: :paciente_id

  def before_validation
    self.email = nil if email&.strip == ''
    super
  end
end