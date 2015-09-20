package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Auto

class AutoHome {
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Auto) ,id) as Auto
	}

	def save(Auto a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}