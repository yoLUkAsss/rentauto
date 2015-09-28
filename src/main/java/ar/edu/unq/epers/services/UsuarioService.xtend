package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.ReservaHome
import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.homes.UsuarioHome

class UsuarioService {
	
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