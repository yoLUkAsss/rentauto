package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Reserva

class ReservaHome {
	
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Reserva) ,id) as Reserva
	}

	def save(Reserva a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}