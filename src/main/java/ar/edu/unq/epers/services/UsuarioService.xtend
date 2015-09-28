package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.ReservaHome
import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.homes.UsuarioHome
import ar.edu.unq.epers.model.Usuario

class UsuarioService {
	
	
	
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
	
	def guardarReserva(Integer id,Reserva reserva) {
		SessionManager.runInSession([
			var usuario = new UsuarioHome().get(id)
			usuario.agregarReserva(reserva)
			new ReservaHome().save(reserva)
			new UsuarioHome().save(usuario)
			usuario
		]);
		
	}
	
}