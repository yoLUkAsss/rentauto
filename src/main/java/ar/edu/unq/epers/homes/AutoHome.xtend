package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Auto
import java.util.List

import ar.edu.unq.epers.model.Reserva
import org.hibernate.Query
import ar.edu.unq.epers.model.Categoria

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
	
	def List<Auto> obtenerTodosLosAutosDeCategoria(Categoria categoria) {
		var Query q = SessionManager.getSession().createQuery("from Auto where auto_categoria= :cat")
		q.setEntity("cat", categoria)
		var List<Auto> autos = q.list()
		return autos;
	}
	

	
}
