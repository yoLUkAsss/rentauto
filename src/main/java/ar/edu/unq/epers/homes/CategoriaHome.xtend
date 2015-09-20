package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Categoria

class CategoriaHome {
	
	
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Categoria) ,id) as Categoria
	}

	def save(Categoria a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}