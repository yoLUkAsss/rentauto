package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.homes.UsuarioHome
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Usuario

class UsuarioService {
	
	
	/**
	 * 
	 * 
	 * @param nombre  Indica el nombre del usuario
	 * @param apellido Indica el apellido del usuario
	 * @param nombreDeUsuario Indica el nombre elegido por el usuario 
	 * @param mail Indice mail del usuario 
	 * @param fechaDeNacimiento Indica la fecha de nacimiento del usuario
	 * @param validez Indica si el usuario esta validado
	 * @param codigo Indica el codigo de validación que recibe el usuario cuando se registra en el sistema 
	 * @param password Indica la contraseña del usuario 
	 * @return No hay
	 * 
	 * @author
	 * 
	 * @see ar.edu.unq.epers.model.Usuario
	 * 
	 * 
	 */
	def crearUsuario(String nombre,String apellido,String nombreDeUsuario,String email,String fechaDeNacimiento,boolean validez,String codigo,String password) {
		SessionManager.runInSession([
			var usuario = new Usuario(nombre,apellido,nombreDeUsuario,email,fechaDeNacimiento,validez,codigo,password)
			new UsuarioHome().save(usuario)
			usuario
		]);
	}
	
	def consultarUsuario(Integer id) {
		SessionManager.runInSession([
			new UsuarioHome().get(id)
		])
	}

	
}