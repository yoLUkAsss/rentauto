package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Auto
import java.util.List
import org.hibernate.Query

class AutoHome {
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Auto) ,id) as Auto
	}

	def save(Auto a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
	/**
	 * Obtiene la lista de todos los autos en nuestra base de datos
	 * 
	 * @see ar.edu.unq.epers.model.Auto
	 */
	def List<Auto> obtenerTodosLosAutos() {
		var Query q = SessionManager.getSession().createQuery("from Auto")
		var List<Auto> autos = q.list()
		return autos;
	}
}