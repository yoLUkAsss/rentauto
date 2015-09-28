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

import ar.edu.unq.epers.model.Categoria
import java.util.ArrayList
import ar.edu.unq.epers.homes.UsuarioHome
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import ar.edu.unq.epers.excepciones.AutoNoExisteException

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
	 * @param fechaFin Indica la fecha en la que se dejaria el auto en la ubicacion final especificada
	 * @param categoria Indica la cateogira del auto que se quiere
	 * @return Los autos disponibles segun lo indicado
	 * 
	 */
	def consultaDeReserva(Ubicacion ubicacionInicial, Ubicacion ubicacionFinal, Date fechaInicio, Date fechaFinal, Categoria categoria) {
		SessionManager.runInSession[|
			var List<Auto> autosTotales = new AutoHome().obtenerTodosLosAutos;
			var List<Auto> autosADevolver = new ArrayList<Auto>();
			for(Auto each : autosTotales){
				if( each.ubicacionParaDia(fechaInicio).equals(ubicacionInicial) && each.estaLibre(fechaInicio,fechaFinal) && each.isCategory(categoria)){
					autosADevolver.add(each);
				}
			}
			autosADevolver
			//autosTotales.filter[each | each.ubicacionParaDia(fechaInicio).equals(ubicacionInicial) && each.estaLibre(fechaInicio,fechaFinal) && each.isCategory(categoria)]	
		]
		
		
	}
	
	
	def crearReserva(Integer numeroSolicitud,Ubicacion origen,Ubicacion destino,Date inicio,Date fin,Auto automovil,Usuario usu) {
	    
	    SessionManager.runInSession([
	    	
	    	var List<Auto> autos= new AutoHome().obtenerTodosLosAutos
	    	var auto= autos.findFirst[au|au.equals(automovil)]
	    	if (auto==null){
	    		
	    		throw new AutoNoExisteException
	    	}
	    	
	    	var List<Usuario>usuarios=new UsuarioHome().obtenerTodosLosUsuarios
	    	var usuario= usuarios.findFirst[u|u.equals(usu)]
			if (usuario==null){
				
			  throw	new UsuarioNoExisteException
			}
			
			var reserva = new Reserva(numeroSolicitud,origen,destino,inicio,fin,auto,usuario);
			new AutoService().guardarReserva(auto.id,reserva)
			new UsuarioService().guardarReserva(usuario.id,reserva)
			new ReservaHome().save(reserva)
			reserva
			
		]);
	}

    
	
}
