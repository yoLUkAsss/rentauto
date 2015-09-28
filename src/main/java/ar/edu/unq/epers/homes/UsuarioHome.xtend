package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Usuario
import java.util.List
import org.hibernate.Query

class UsuarioHome {
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Usuario) ,id) as Usuario
	}

	def save(Usuario a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
	def List<Usuario> obtenerTodosLosUsuarios() {
		var Query q = SessionManager.getSession().createQuery("from Usuario")
		var List<Usuario> usuarios = q.list()
		return usuarios;
	}
	
	
}