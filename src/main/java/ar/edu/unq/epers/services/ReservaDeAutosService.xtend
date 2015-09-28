package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.homes.AutoHome
import java.util.List
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.homes.ReservaHome
import ar.edu.unq.epers.model.Usuario

class ReservaDeAutosService {
	
	/**
	 * Retorna la cantidad de autos disponibles para cierta ubicacion en una determinada fecha
	 * 
	 * @param determinadaUbicacion Indica la ubicacion la cual se necesita
	 * @param determinadoDia Indica el dia en el que se necesita la disponibilidad de los autos
	 * @return La cantidad de autos disponibles segun lo indicado
	 * 
	 */
	def autosDisponibles(Ubicacion determinadaUbicacion , Date determinadoDia) {
		SessionManager.runInSession[|
			var List<Auto> autosTotales = new AutoHome().obtenerTodosLosAutos
			autosTotales.filter[each | each.ubicacionParaDia(determinadoDia).equals(determinadaUbicacion)].size
		]
	}
	
	
	def crearReserva(Integer numeroSolicitud,Ubicacion origen,Ubicacion destino,Date inicio,Date fin,Auto auto,Usuario usuario){
	    
	    SessionManager.runInSession([
			var reserva = new Reserva(numeroSolicitud,origen,destino,inicio,fin,auto,usuario);
			new AutoService().guardarReserva(auto.id,reserva)
			new UsuarioService().guardarReserva(usuario.id,reserva)
			reserva
			
		]);
	
	
	
	
	}

	
}