package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Ubicacion

class UbicacionHome {
	
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Ubicacion) ,id) as Ubicacion
	}

	def save(Ubicacion a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}