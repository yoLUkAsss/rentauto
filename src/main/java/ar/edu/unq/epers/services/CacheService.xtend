package ar.edu.unq.epers.services

import ar.edu.unq.epers.cassandra.CachedCar
import ar.edu.unq.epers.homes.AdminHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.BusquedaPorDiaReserva
import ar.edu.unq.epers.model.Ubicacion
import com.datastax.driver.mapping.MappingManager
import java.util.ArrayList
import java.util.Date
import java.util.List

/**
 * Servicio de Cache para cachear los autos disponibles dado cierto dia y cierta ubicacion.
 * El sistema tiene actualizacion ante cambios en la informacion.
 * 
 * @author Leutwyler Nicolas
 * @author Sandoval Lucas
 * @author Zaracho Rosali
 * 
 */
class CacheService {
	
	new () {}
	
	/**
	 * Dado un dia y una ubicacion, ingresa en Cache la lista de autos disponibles correspondientes
	 * a dichos parametros
	 * 
	 * @param dia Dia clave para la info
	 * @param ubicacion Ubicacion clave para la info
	 * @param autos Lista de autos a cachear con dicha clave
	 */
	def cachear (Date dia , Ubicacion ubicacion , List <CachedCar> autos) {
		
		System.out.println("Hasta aca todo bien")
		
		
		AdminHome.getInstance.runInSession([|
			var miMapping = new MappingManager(AdminHome.getInstance.session)
			var mapper = miMapping.mapper(typeof (BusquedaPorDiaReserva))
			var res = mapper.get(dia,ubicacion)
			if (res == null)
				res = new BusquedaPorDiaReserva(dia,ubicacion.nombre,autos)
			else 
				for (CachedCar auto : autos) {
					res.agregarAuto(auto)
				}
			miMapping.mapper(BusquedaPorDiaReserva).save(res)
			null])
	}
	
	/**
	 * Obtiene la informacion de Cache
	 * 
	 * @param dia Dia en el que se busca a los autos disponibles
	 * @param ubicacion Ubicacion en la que se busca a los autos disponibles
	 * 
	 * @return La informacion correspondiente a la busqueda por Cache
	 * 
	 * @see ar.edu.unq.epers.model.BusquedaPorDiaReserva
	 */
	def getCached (Date dia , Ubicacion ubicacion) {
		AdminHome.getInstance.runInSession([|
			var miMapping = new MappingManager(AdminHome.getInstance.session)
			return miMapping.mapper(BusquedaPorDiaReserva).get(dia,ubicacion)
		])
	}
	
	/**
	 * Se encarga de actualizar la Cache al recibir la informacion de cambios en el sistema
	 * 
	 * @param inicio Fecha de inicio de una reserva nueva
	 * @param fin Fecha de fin de la reserva
	 * @param auto Es el auto al que hay que actualizarle sus datos en la cache
	 */
	def deleteCachedCarBetween(Date inicio , Date fin , CachedCar auto) {
		var res = AdminHome.getInstance.allDataBetweenDates(inicio,fin)
		for (BusquedaPorDiaReserva elem : res) {
			if (elem.autos.contains(auto))
				elem.borrarAuto(auto)
			this.cachear(inicio,new Ubicacion(elem.ubicacion),elem.autos)
		}			
	}
	
	
	
	def cleanCache(){
		AdminHome.getInstance.cleanDatabase
	}
}