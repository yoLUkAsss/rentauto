package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.AutoHome
import ar.edu.unq.epers.homes.ReservaHome
import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import java.util.ArrayList
import java.util.Date
import java.util.List

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
	
	/**
	 * Retorna la cantidad de autos disponibles para cierta ubicacion en un plazo determinado por
	 * fecha de inicio y fecha fin, con la categoria especificada
	 * 
	 * @param ubicacionInicial Indica la ubicacion la cual se necesita
	 * @param ubicacionFinal Indica la ubicacion en la que se dejaria el auto
	 * @param fechaInicio Indica la fecha en la que se necesita retirar el auto
	 * @param fechaFinal Indica la fecha en la que se dejaria el auto en la ubicacion final especificada
	 * @param categoria Indica la cateogira del auto que se quiere
	 * @return Los autos disponibles segun lo indicado
	 * 
	 */
	def consultaDeReserva(Ubicacion ubicacionInicial, Ubicacion ubicacionFinal, Date fechaInicio, Date fechaFinal, Categoria categoria) {
		SessionManager.runInSession[|
			var List<Auto> autosTotales = new AutoHome().obtenerTodosLosAutosDeCategoria(categoria);
			var List<Auto> autosADevolver = new ArrayList<Auto>();
			for(Auto each : autosTotales){
				if( each.ubicacionParaDia(fechaInicio).equals(ubicacionInicial) && each.estaLibre(fechaInicio,fechaFinal)){
					autosADevolver.add(each);
				}
			}
			return autosADevolver
		
		]
		
		
	}
	
	/**
	 * Este metodo se encarga de crear y preservar la informacion de una reserva.
	 * 
	 * @param numeroSolicitud Nro de reserva
	 * @param origen Indica la ubicación origen de la reserva
	 * @param destino Indica la unbicación destino de la reserva
	 * @param inicio Fecha inicial de la reserva
	 * @param fin Fecha de finalización de reserva
	 * @param usuario Indica al usuario que realiza la reserva
	 * @param auto Indica al vehiculo reservado
	 * 
	 * @see ar.edu.unq.epers.model.Auto
	 * @see ar.edu.unq.epers.model.Ubicacion
	 * @see ar.edu.unq.epers.model.Usuario 
	 */
	def crearReserva(Integer numeroSolicitud,Ubicacion origen,Ubicacion destino,Date inicio,Date fin,Usuario usuario, Auto auto) {  
	    SessionManager.runInSession([
			var reserva = new Reserva(numeroSolicitud,origen,destino,inicio,fin,auto,usuario);
			reserva.reservar
			new ReservaHome().save(reserva)
			reserva			
		]);
	}

    
	
}
