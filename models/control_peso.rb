require_relative '../database'

class ControlPeso < Sequel::Model(:controles_peso)
  set_primary_key :id_control

  many_to_one :paciente, class: :Paciente, key: :paciente_id

  # Diferencia con el control anterior (si existe)
  def diferencia_con_anterior
    anterior = ControlPeso.where(paciente_id: paciente_id)
                          .where { fecha < self.fecha }
                          .order(Sequel.desc(:fecha))
                          .first
    return nil unless anterior
    (peso - anterior.peso).round(2)
  end

  def resumen
    dif = diferencia_con_anterior
    if dif
      signo = dif > 0 ? "▲" : "▼"
      "#{fecha}: #{peso} kg (#{signo} #{dif.abs} kg)"
    else
      "#{fecha}: #{peso} kg (primer control)"
    end
  end
end